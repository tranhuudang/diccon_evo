import 'dart:async';
import 'dart:io';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/core/configs/api_key.dart';
import 'package:diccon_evo/src/data/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../data/helpers/file_helper.dart';
import '../../../data/repositories/audio_repository.dart';
import '../../../data/repositories/speech_to_text_repository.dart';
import '../../../data/repositories/text_to_speech_repository.dart';

// Events
@immutable
abstract class VoiceEvent {}

class StartRecordEvent extends VoiceEvent {}

class SpeechToTextEvent extends VoiceEvent {
  final String recordedFilePath;
  SpeechToTextEvent({required this.recordedFilePath});
}

class TextCompletionEvent extends VoiceEvent {
  final String requestMessage;
  TextCompletionEvent({required this.requestMessage});
}

class TextToSpeechEvent extends VoiceEvent {
  final String textReceivedFromBot;
  TextToSpeechEvent({required this.textReceivedFromBot});
}

class StartBotSpeechEvent extends VoiceEvent {
  final String fileNameToPlay;
  StartBotSpeechEvent({required this.fileNameToPlay});
}

class StopRecordEvent extends VoiceEvent {}

class UserSpeakingEvent extends VoiceEvent {
  final double decibelValue;
  UserSpeakingEvent({required this.decibelValue});
}

// States
abstract class VoiceState {}

class VoiceActionState extends VoiceState {}

class UserNotAllowRecordState extends VoiceActionState {}
class VoiceChatNoInternetState extends VoiceActionState {}

class VoiceInitState extends VoiceState {}

class VoiceBotThinkingState extends VoiceState {}
class VoiceBotSpeakingState extends VoiceState {}

class VoiceUserSpeakingState extends VoiceState {
  double decibelValue;
  VoiceUserSpeakingState({this.decibelValue = 0});
}

// Bloc
class VoiceBloc extends Bloc<VoiceEvent, VoiceState> {
  VoiceBloc() : super(VoiceInitState()) {
    on<StartRecordEvent>(_startRecord);
    on<SpeechToTextEvent>(_speechToText);
    on<TextCompletionEvent>(_textCompletion);
    on<TextToSpeechEvent>(_textToSpeech);
    on<StartBotSpeechEvent>(_startBotSpeech);
    on<StopRecordEvent>(_stopRecord);
    on<UserSpeakingEvent>(_userSpeaking);
  }

  // Repository for interacting with the ChatGPT API
  final _chatGptRepository = ChatGptRepositoryImplement(chatGpt: ChatGpt(apiKey: ApiKeys.openAiKey));

  // Stream subscription for handling responses from ChatGPT
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  // Repositories for speech-to-text, text-to-speech, and audio handling
  final _speechToTextRepository = SpeechToTextRepository();
  final _textToSpeechRepository = TextToSpeechRepository();
  final _audioRepository = AudioRepository();

  // Variables for managing conversation flow and audio analysis
  // _answerIndex grow by 1 over each question, this value will be used to name local audio file
  // during the recording and download text-to-speech file
  int _answerIndex = 0;
  // When user do talk something, this value will increase to _maxDelayIndex and then when it reached the _maxDelayIndex
  // it mean that user delay talking and we should switch to bot turn to think and speak
  int _delayIndex = 0;
  // 20 of _maxDelayIndex with _subscriptionDuration = 100 equal to 2 seconds of delay when user finished their speaking.
  final int _maxDelayIndex = 20;
  bool _userHadSpeak = false;
  bool _isCancel = false;
  int _userHadSpeakIndex = 0;
  // Set _isContinuousConversation to false will stop the conversation in each question - answer
  final bool _isContinuousConversation = true;
  final double _subscriptionDuration = 100;
  final int _silentDecibelThreshold = 42;
  // When user talk something, with _userSpeakingLength = 3 and _subscriptionDuration = 100, it means that
  // we only recognize 300 milliseconds length of talking is a valid question, those shorter will be ignored.
  final int _userSpeakingLength = 3;

  /// Function to start recording audio
  ///
  /// Parameters:
  /// - event: [StartRecordEvent] object triggering the start of recording
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _startRecord(
    StartRecordEvent event,
    Emitter<VoiceState> emit,
  ) async {
    _isCancel = false;
    bool recordPermission = await _requestPermission();
    if (recordPermission) {
      // Make sure internet is connected
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print('[Internet Connection] $isInternetConnected');
      }
      if (!isInternetConnected) {
        emit(VoiceChatNoInternetState());
      } else {
        emit(VoiceUserSpeakingState());
        await _audioRepository.startRecorder('file$_answerIndex.mp4');
        await _audioRepository.setSubscriptionDuration(_subscriptionDuration);
        _audioRepository.startRecorderSubscriptions((e) async {
          if (kDebugMode) {
            print('[StartRecordEvent] Silent time: $_delayIndex');
          }
          // Let assume with sounds < 35 decibels is silent sounds
          if (e.decibels! < _silentDecibelThreshold && _userHadSpeak) {
            _delayIndex = _delayIndex + 1;
          } else {
            _delayIndex = 0;
          }
          // Detect that user do say something
          if (e.decibels! > _silentDecibelThreshold) {
            _userHadSpeakIndex = _userHadSpeakIndex + 1;
            add(UserSpeakingEvent(decibelValue: e.decibels!));
          }
          if (_userHadSpeakIndex > _userSpeakingLength) {
            _userHadSpeak = true;
          }
          // [5] [6]
          if (_delayIndex >= _maxDelayIndex) {
            if (kDebugMode) {
              print('[StartRecordEvent] User stopped talking');
            }
            _audioRepository.cancelRecorderSubscriptions();
            // Stop recorder and prepare to send result to Whisper
            // [7] stt
            String? outputFilePath = await _audioRepository.stopRecorder();
            if (outputFilePath != null) {
              add(SpeechToTextEvent(recordedFilePath: outputFilePath));
              if (kDebugMode) {
                print(
                  '[StartRecordEvent] Output recorded FilePath: $outputFilePath',
                );
              }
            } else {
              if (kDebugMode) {
                print('[StartRecordEvent] No output file path found.');
              }
            }
          }
        });
      }
    } else {
      emit(UserNotAllowRecordState());
    }
  }

  /// Function to convert speech to text
  ///
  /// Parameters:
  /// - event: [SpeechToTextEvent] object containing the recorded audio file path
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _speechToText(
    SpeechToTextEvent event,
    Emitter<VoiceState> emit,
  ) async {
    emit(VoiceBotThinkingState());

    final targetFile = File(event.recordedFilePath);
    final bytes = await targetFile.readAsBytes();
    final audioData = ByteData.view(bytes.buffer);
    // Get result from whisper
    // [8]
    final jsonResult = await _speechToTextRepository.convertSpeechToText(
      fileName: 'file$_answerIndex.mp4',
      audio: audioData.buffer.asByteData(),
      model: 'whisper-1',
    );
    if (kDebugMode) {
      print('[SpeechToTextEvent] ${jsonResult['text']}');
    }
    add(TextCompletionEvent(requestMessage: jsonResult['text']));
  }

  /// Function to handle text completion based on user input
  ///
  /// Parameters:
  /// - event: [TextCompletionEvent] object with user input message
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _textCompletion(
    TextCompletionEvent event,
    Emitter<VoiceState> emit,
  ) async {
    var request = await _chatGptRepository
        .createMultipleQuestionRequest(event.requestMessage);
    _chatStreamResponse(request);
  }

  /// Function to convert text to speech
  ///
  /// Parameters:
  /// - event: [TextToSpeechEvent] object containing the text to be converted
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _textToSpeech(
    TextToSpeechEvent event,
    Emitter<VoiceState> emit,
  ) async {
    Directory fileDirectory = await getApplicationCacheDirectory();
    final savingFilePath = join(fileDirectory.path, 'tts$_answerIndex.mp3');
    await _textToSpeechRepository.convertTextToSpeech(
      fromText: event.textReceivedFromBot,
      toFilePath: savingFilePath,
    );
    if (kDebugMode) {
      print('[TextToSpeechEvent] Save speech to: $savingFilePath');
    }
    if (!_isCancel) {
      add(StartBotSpeechEvent(fileNameToPlay: savingFilePath));
    }
  }

  /// Function to handle bot speech initiation and continuation of conversation
  ///
  /// Parameters:
  /// - event: [StartBotSpeechEvent] object for initiating bot speech
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _startBotSpeech(
    StartBotSpeechEvent event,
    Emitter<VoiceState> emit,
  ) async {
    Directory fileDirectory = await getApplicationCacheDirectory();
    emit(VoiceBotSpeakingState());
    _audioRepository
        .startPlayer(join(fileDirectory.path, 'tts$_answerIndex.mp3'), () {
      _answerIndex = _answerIndex + 1;
      _delayIndex = 0;
      _userHadSpeak = false;
      _userHadSpeakIndex = 0;
      if (_isContinuousConversation) {
        if (kDebugMode) {
          print('[StartBotSpeechEvent] Continue the conversation');
        }
        add(StartRecordEvent());
      } else {
        add(StopRecordEvent());
      }
      if (kDebugMode) {
        print('[StartBotSpeechEvent] Bot completed speaking');
      }
    });
  }

  /// Function to handle stopping the recording event
  ///
  /// Parameters:
  /// - event: [StopRecordEvent] object triggering the stop of recording
  /// - emit: [Emitter] for emitting [VoiceState] events
  Future<FutureOr<void>> _stopRecord(
    StopRecordEvent event,
    Emitter<VoiceState> emit,
  ) async {
    emit(VoiceInitState());
    await _removeTempVoiceCache();
    _isCancel = true;
    _audioRepository.dispose();
    await _chatStreamSubscription?.cancel();
    _chatGptRepository.reset();
    _resetVoiceIndexes();
    _textToSpeechRepository.dispose();
    emit(VoiceInitState());
  }

  Future<void> _userSpeaking(
    UserSpeakingEvent event,
    Emitter<VoiceState> emit,
  ) async {
    emit(VoiceUserSpeakingState(decibelValue: event.decibelValue));
  }

  /// Function to request microphone permission
  ///
  /// Returns:
  /// - Future of [bool] value indicating if the permission was granted or not
  Future<bool> _requestPermission() async {
    var status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return false;
    }
    return true;
  }

  /// Function to remove temporary voice cache
  Future<void> _removeTempVoiceCache() async {
    await FileHelper.clearCache();
  }

  /// Function to reset voice-related indexes, so that when we continue or start again, it not break the whole function
  void _resetVoiceIndexes() {
    _delayIndex = 0;
    _userHadSpeak = false;
    _userHadSpeakIndex = 0;
    _answerIndex = 0;
  }

  /// Function to handle text completion responses from ChatGPT
  ///
  /// Parameters:
  /// - request: [ChatCompletionRequest] object for requesting a chat completion from ChatGPT
  Future<void> _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    try {
      final stream =
          await _chatGptRepository.chatGpt.createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen((event) {
        if (event.streamMessageEnd) {
          _chatStreamSubscription?.cancel();
          // Some condition when chat bot finish responding
          // Upload gpt text response to get speech
          // [11]
          if (!_isCancel) {
            String lastAnswer = _chatGptRepository
                .questionAnswers[_answerIndex].answer
                .toString();
            if (kDebugMode) {
              print('[TextCompletionEvent] Last answer: $lastAnswer');
            }
            add(TextToSpeechEvent(textReceivedFromBot: lastAnswer));
          }
        } else {
          if (kDebugMode) {
            print('[TextCompletionEvent] Bot answering');
          }
          if (!_isCancel) {
            return _chatGptRepository.questionAnswers.last.answer.write(
              event.choices?.first.delta?.content,
            );
          }
        }
      });
    } catch (error) {
      if (kDebugMode) {
        print('[TextCompletionEvent] Error occurred: $error');
      }
    }
  }
}
