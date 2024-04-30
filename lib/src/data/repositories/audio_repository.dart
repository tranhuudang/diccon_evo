import 'dart:async';

import 'package:diccon_evo/src/data/data.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

class AudioRepository {
  AudioHandler audioHandler = AudioHandler.instance;

  /// Initiates subscriptions for recording audio and listens for changes.
  ///
  /// Parameters:
  /// - onValueChanged: Callback function triggered on recording disposition change.
  StreamSubscription<dynamic>? startRecorderSubscriptions(
    Function(RecordingDisposition) onValueChanged,
  ) {
    return audioHandler.startRecorderSubscriptions(onValueChanged);
  }

  /// Cancels subscriptions for recording audio.
  void cancelRecorderSubscriptions() {
    audioHandler.cancelRecorderSubscriptions();
  }

  /// Sets the duration delay in which the recorder subscription will wait to return a [RecordingDisposition] value.
  /// Smaller value result to a faster callback on onValueChanged in [startRecorderSubscriptions].
  ///
  /// Parameters:
  /// - duration: The duration (in milliseconds) for the audio recording subscription.
  Future<void> setSubscriptionDuration(double duration) async {
    if (!audioHandler.isInitialized) {
      await AudioHandler.initialize();
    }
    await audioHandler.setSubscriptionDuration(duration);
  }

  /// Starts the audio recording process and saves to the specified file path.
  ///
  /// Parameters:
  /// - targetFilePath: The file path where the recorded audio will be saved.
  Future<void> startRecorder(String targetFilePath) async {
    if (!audioHandler.isInitialized) {
      await AudioHandler.initialize();
    }
    await audioHandler.startRecorder(targetFilePath);
  }

  /// Stops the audio recording and returns the file path of the recorded audio.
  ///
  /// Returns:
  /// - A [String] representing the file path of the recorded audio.
  Future<String?> stopRecorder() async {
    return await audioHandler.stopRecorder();
  }

  /// Starts playing audio from the provided URI and triggers a function on finish.
  ///
  /// Parameters:
  /// - fromURI: The URI or file path from where the audio playback will start.
  /// - onFinish: Callback function triggered upon completion of audio playback.
  void startPlayer(String fromURI, Function()? onFinish) async {
    if (!audioHandler.isInitialized) {
      await AudioHandler.initialize();
    }
    audioHandler.startPlayer(fromURI, onFinish);
  }

  /// Stops the audio player.
  void stopPlayer() {
    audioHandler.stopPlayer();
  }

  /// Disposes of resources used for audio handling.
  void dispose() {
    audioHandler.dispose();
  }
}
