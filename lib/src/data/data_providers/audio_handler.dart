import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';

const theSource = AudioSource.microphone;

class AudioHandler {
  AudioHandler._privateConstructor();
  bool _isInitialized = false;
  static final AudioHandler instance = AudioHandler._privateConstructor();

  FlutterSoundPlayer? _mPlayer = FlutterSoundPlayer();
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  double _mSubscriptionDuration = 300;
  StreamSubscription? _recorderSubscription;
  int pos = 0;
  double dbLevel = 0;
  final Codec _codec = Codec.aacMP4;
  static Future<void> initialize() async {
    if (!instance._isInitialized) {
      await instance._initializeRecorder();
    }
  }

  bool get isInitialized => _isInitialized;

  // Initializes the FlutterSoundRecorder and FlutterSoundPlayer
  Future<bool> _initializeRecorder() async {
    try {
      await _mRecorder!.openRecorder();
      await _mPlayer!.openPlayer();
      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
          avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
          avAudioSessionCategoryOptions:
              AVAudioSessionCategoryOptions.allowBluetooth |
                  AVAudioSessionCategoryOptions.defaultToSpeaker,
          avAudioSessionMode: AVAudioSessionMode.spokenAudio,
          avAudioSessionRouteSharingPolicy:
              AVAudioSessionRouteSharingPolicy.defaultPolicy,
          avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
          androidAudioAttributes: const AndroidAudioAttributes(
            contentType: AndroidAudioContentType.speech,
            flags: AndroidAudioFlags.none,
            usage: AndroidAudioUsage.voiceCommunication,
          ),
          androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
          androidWillPauseWhenDucked: true,
        ),
      );
      _isInitialized = true;
      print('Audio initialized');
      return true;
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.initializingRecorder}$e');
    }
  }

  /// Initiates subscriptions for recording audio and listens for changes.
  ///
  /// Parameters:
  /// - onValueChanged: Callback function triggered on recording disposition change.
  StreamSubscription<dynamic>? startRecorderSubscriptions(
      Function(RecordingDisposition) onValueChanged) {
    _recorderSubscription = _mRecorder?.onProgress!.listen((e) {
      print("audio handler subbcription");
      onValueChanged(e);
      pos = e.duration.inMilliseconds;
      if (e.decibels != null) {
        dbLevel = e.decibels as double;
      }
    });
    return _recorderSubscription;
  }

  /// Cancels subscriptions for recording audio.
  void cancelRecorderSubscriptions() {
    if (_recorderSubscription != null) {
      _recorderSubscription!.cancel();
      _recorderSubscription = null;
    }
  }

  /// Sets the duration for the audio recording subscription.
  /// Smaller value result to a faster callback on onValueChanged in [startRecorderSubscriptions].
  ///
  /// Parameters:
  /// - d: The duration (in milliseconds) for the audio recording subscription.
  Future<void> setSubscriptionDuration(double d) async {
    _mSubscriptionDuration = d;
    await _mRecorder?.setSubscriptionDuration(
      Duration(milliseconds: d.floor()),
    );
  }

  /// Starts the audio recording process and saves to the specified file path.
  ///
  /// Parameters:
  /// - targetFilePath: The file path where the recorded audio will be saved.
  Future<void> startRecorder(String targetFilePath) async {
    try {
      await _mRecorder!.startRecorder(
        toFile: targetFilePath,
        codec: _codec,
        audioSource: theSource,
      );
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.startingRecorder}$e');
    }
  }

  /// Stops the audio recording and returns the file path of the recorded audio.
  ///
  /// Returns:
  /// A [String] representing the file path of the recorded audio.
  Future<String?> stopRecorder() async {
    try {
      return await _mRecorder!.stopRecorder();
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.stoppingRecorder}$e');
    }
  }

  /// Starts playing audio from the provided URI and triggers a function on finish.
  ///
  /// Parameters:
  /// - fromURI: The URI or file path from where the audio playback will start.
  /// - onFinish: Callback function triggered upon completion of audio playback.
  void startPlayer(String fromURI, Function()? onFinish) {
    try {
      _mPlayer!.startPlayer(fromURI: fromURI, whenFinished: onFinish);
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.startingPlayer}$e');
    }
  }

  /// Stops the audio player.
  void stopPlayer() {
    try {
      _mPlayer!.stopPlayer();
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.stoppingPlayer}$e');
    }
  }

  /// Disposes of resources used for audio handling.
  void dispose() {
    _isInitialized = false;
    try {
      _mPlayer!.closePlayer();
      //_mPlayer = null;

      _mRecorder!.closeRecorder();
      //_mRecorder = null;

      cancelRecorderSubscriptions();
    } catch (e) {
      throw AudioHandlerException('${ExceptionStrings.disposing}$e');
    }
  }
}
