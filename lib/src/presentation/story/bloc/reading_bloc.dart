import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/data/data_providers/text_to_speech_client.dart';
import 'package:diccon_evo/src/data/handlers/file_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../core/utils/md5_generator.dart';
import '../../../domain/domain.dart';

/// Params
class ReadingBlocParams {
  final bool isBottomAppBarVisible;
  final bool isDownloading;
  final bool isDownloaded;
  final double fontSize;
  final String audioFilePath;
  ReadingBlocParams({
    required this.isBottomAppBarVisible,
    required this.isDownloading,
    required this.isDownloaded,
    required this.fontSize,
    required this.audioFilePath,
  });
  static ReadingBlocParams init() {
    return ReadingBlocParams(
      isBottomAppBarVisible: true,
      isDownloading: false,
      isDownloaded: false,
      fontSize: Properties.instance.settings.readingFontSize,
      audioFilePath: '',
    );
  }

  ReadingBlocParams copyWith({
    bool? isBottomAppBarVisible,
    bool? isDownloading,
    bool? isDownloaded,
    double? fontSize,
    String? audioFilePath,
  }) {
    return ReadingBlocParams(
      isBottomAppBarVisible:
          isBottomAppBarVisible ?? this.isBottomAppBarVisible,
      isDownloading: isDownloading ?? this.isDownloading,
      isDownloaded: isDownloaded ?? this.isDownloaded,
      fontSize: fontSize ?? this.fontSize,
      audioFilePath: audioFilePath ?? this.audioFilePath,
    );
  }
}

/// States
abstract class ReadingState {
  ReadingBlocParams params;
  ReadingState({required this.params});
}

class ReadingActionState extends ReadingState {
  ReadingActionState({required super.params});
}

class DeletedWordAndSentenceTranslationData extends ReadingActionState {
  DeletedWordAndSentenceTranslationData({required super.params});
}

class ReadingInitState extends ReadingState {
  ReadingInitState({required super.params});
}

class ReadingUpdatedState extends ReadingState {
  ReadingUpdatedState({required super.params});
}

/// Events
abstract class ReadingEvent {}

class IncreaseFontSize extends ReadingEvent {}

class DeleteTranslatedContentInThisWordAndSentenceEvent extends ReadingEvent {
  final String word;
  final String sentenceContainWord;
  DeleteTranslatedContentInThisWordAndSentenceEvent(
      {required this.word, required this.sentenceContainWord});
}

class DecreaseFontSize extends ReadingEvent {}

class InitReadingBloc extends ReadingEvent {
  final Story story;
  InitReadingBloc({required this.story});
}

class DownloadAudio extends ReadingEvent {
  final Story story;
  DownloadAudio({required this.story});
}

/// Bloc
class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  ReadingBloc() : super(ReadingInitState(params: ReadingBlocParams.init())) {
    on<InitReadingBloc>(_initReadingBloc);
    on<IncreaseFontSize>(_increaseFontSize);
    on<DecreaseFontSize>(_decreaseFontSize);
    on<DownloadAudio>(_downloadAudio);
    on<DeleteTranslatedContentInThisWordAndSentenceEvent>(
        _deleteTranslatedContentInThisWordAndSentence);
  }

  FutureOr<void> _initReadingBloc(
      InitReadingBloc event, Emitter<ReadingState> emit) async {
    emit(ReadingInitState(params: ReadingBlocParams.init()));
    // Check if audio file of this story is already downloaded before
    final cacheDir = await getApplicationCacheDirectory();
    String filePath = join(
        cacheDir.path, '${event.story.title.removeSpecialCharacters()}.mp3');
    File audioFile = File(filePath);
    if (await audioFile.exists()) {
      DebugLog.info(
          'Audio of "${event.story.title}" story is exist in cache folder');
      emit(
        ReadingUpdatedState(
          params: state.params.copyWith(
            isDownloaded: true,
            audioFilePath: filePath,
          ),
        ),
      );
    }
  }

  FutureOr<void> _increaseFontSize(
      IncreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize =
        Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize < 70) {
      emit(ReadingUpdatedState(
          params: state.params.copyWith(fontSize: state.params.fontSize + 2)));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize + 2);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _decreaseFontSize(
      DecreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize =
        Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize > 10) {
      emit(ReadingUpdatedState(
          params: state.params.copyWith(
        fontSize: state.params.fontSize - 2,
      )));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize - 2);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _deleteTranslatedContentInThisWordAndSentence(
      DeleteTranslatedContentInThisWordAndSentenceEvent event,
      Emitter<ReadingState> emit) async {
    bool isDeleteWordTranslationCompleted =
        await _deleteWordDefinitionOnFirestore(
            word: event.word, sentenceContainWord: event.sentenceContainWord);
    bool isDeleteSentenceTranslationCompleted =
        await _deleteSentenceTranslationOnFirestore(
            sentenceContainWord: event.sentenceContainWord);
    if (isDeleteWordTranslationCompleted &&
        isDeleteSentenceTranslationCompleted) {
      emit(DeletedWordAndSentenceTranslationData(params: state.params));
    }
  }

  Future<bool> _deleteWordDefinitionOnFirestore(
      {required String word, required String sentenceContainWord}) async {
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: sentenceContainWord + word);
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        docUser.delete().then((_) {
          DebugLog.info('Delete data row successfully!');
          return true;
        }).catchError((error) {
          DebugLog.error("Failed to delete document: $error");
          return false;
        });
      }
    });
    return false;
  }

  Future<bool> _deleteSentenceTranslationOnFirestore(
      {required String sentenceContainWord}) async {
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: sentenceContainWord);
    final docUser = FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.story)
        .doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        docUser.delete().then((_) {
          DebugLog.info('Delete data row successfully!');
          return true;
        }).catchError((error) {
          DebugLog.error("Failed to delete document: $error");
          return false;
        });
      }
    });
    return false;
  }

  FutureOr<void> _downloadAudio(
      DownloadAudio event, Emitter<ReadingState> emit) async {
    emit(
      ReadingUpdatedState(
        params: state.params.copyWith(isDownloading: true),
      ),
    );
    final tts = TextToSpeechApiClient();
    final dir = await getApplicationCacheDirectory();
    final fileName = '${event.story.title.removeSpecialCharacters()}.mp3';
    final filePath = join(dir.path, fileName);
    try {
      DebugLog.info('Downloading audio...');
      var isDownloadGithubSuccess = await FileHandler(filePath)
          .downloadToResources("${OnlineDirectory.storiesAudioURL}$fileName");
      if (!isDownloadGithubSuccess) {
        await tts.convertTextToSpeech(
            fromText: event.story.content, toFilePath: filePath);
      }
    } catch (e) {
      DebugLog.error(
          'Can not download audio file, try to convert text to speech using open ai api');
      await tts.convertTextToSpeech(
          fromText: event.story.content, toFilePath: filePath);
    }
    emit(
      ReadingUpdatedState(
        params: state.params.copyWith(
          isDownloaded: true,
          isDownloading: false,
          audioFilePath: filePath,
        ),
      ),
    );
  }
}
