import 'dart:io';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

import '../data.dart';

class SoundHandler {
  final audioPlayer = AudioPlayer();
  final String languageCode = 'en-US';
  int audioLength = 0;
  bool isPlaying = false;

  void playTts(String providedWordToPlay) => _playTts(providedWordToPlay);

  void _playTts(String word) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage(languageCode);
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.34);
    await tts.speak(word);
  }

  String _onlineSoundUrlPath(String providedWordToPlay) {
    // Sample link's format: https://github.com/zeroclubvn/US-Pronunciation/raw/main/A/us/Affected.mp3
    String firstLetter = providedWordToPlay.getFirstLetter().toUpperCase();
    String word = providedWordToPlay.upperCaseFirstLetter();
    String url = "${OnlineDirectory.audioURL}$firstLetter/us/$word.mp3";
    return url;
  }

  Stream<bool> playAnyway(String providedWordToPlay) async* {
    if (providedWordToPlay.numberOfWord() == 1) {
      String url = _onlineSoundUrlPath(providedWordToPlay);
      // Okapi /'ou'kɑ:pi/
      String refinedWord = providedWordToPlay.upperCaseFirstLetter();

      if (kDebugMode) {
        print("playing word: $refinedWord");
      }
      String fileName = "$refinedWord.mp3";
      final soundFilePath =
          await DirectoryHandler.getLocalResourcesFilePath(fileName);
      File file = File(soundFilePath);
      try {
        if (file.existsSync()) {
          await _playLocal(fileName);
          return;
        }
        if (!file.existsSync()) {
          yield false;
          await FileHandler(fileName).downloadToResources(url);
          yield true;
          _playLocal(fileName);
        }
      } catch (e) {
        if (kDebugMode) {
          print("error downloading sound track: $e");
        }
        _playTts(providedWordToPlay);
      }
    } else {
      _playTts(providedWordToPlay);
    }
  }

  Future<bool> _playLocal(String fileName) async {
    try {
      var filePath = await DirectoryHandler.getLocalResourcesFilePath(fileName);
      await audioPlayer.play(UrlSource(filePath));
      return true;
    } catch (e) {
      // Play sound using local tts
      _playTts(fileName.substring(0, fileName.indexOf('.')));
      return false;
    }
  }

  Future<bool> playFromPath(
      {required String filePath,
      required VoidCallback onFinished,
      required Function(double) onPositionChanged}) async {
    try {
      if (audioLength == 0) {
        audioLength = await getAudioLength(filePath);
      }
      if (kDebugMode) {
        print(filePath);
      }
      await audioPlayer.play(DeviceFileSource(filePath));
      audioPlayer.onPlayerComplete.listen((event) {
        onFinished();
      });
      audioPlayer.onPositionChanged.listen((Duration event) {
        double currentPos = event.inMilliseconds / audioLength;
        onPositionChanged(currentPos);
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  /// Return audio length in milliseconds or return 0 if can't get the value
  Future<int> getAudioLength(String filePath) async {
    await audioPlayer.play(DeviceFileSource(filePath));
    Duration duration =
        await audioPlayer.getDuration() ?? const Duration(milliseconds: 1);
    return duration.inMilliseconds;
  }

  /// Go to a specific point of audio with double value from 0 to 1
  seek({required double seekPoint, required String filePath}) async {
    if (audioLength == 0) {
      audioLength = await getAudioLength(filePath);
    }
    audioPlayer.seek(Duration(milliseconds: (audioLength * seekPoint).floor()));
  }

  Future<void> pause() async {
    await audioPlayer.pause();
  }

  Future<void> stop() async {
    await audioPlayer.stop();
  }

  void dispose(){
    audioPlayer.dispose();
  }
}
