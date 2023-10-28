import 'dart:io';
import 'package:diccon_evo/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
class SoundHandler {
  final String providedWordToPlay;
  SoundHandler(this.providedWordToPlay);

  void playTts() => _playTts(providedWordToPlay);

  void _playTts(String word) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage('en-US');
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.5);
    await tts.speak(word);
  }

  String _onlineSoundUrlPath() {
    // Sample link's format: https://github.com/zeroclubvn/US-Pronunciation/raw/main/A/us/Affected.mp3
    String firstLetter = providedWordToPlay.getFirstLetter().toUpperCase();
    String word = providedWordToPlay.getFirstWord().upperCaseFirstLetter();
    String url =
        "https://github.com/zeroclubvn/US-Pronunciation/raw/main/$firstLetter/us/$word.mp3";

    return url;
  }

  Stream<bool> playAnyway() async* {
    String url = _onlineSoundUrlPath();
    // Okapi /'ou'kɑ:pi/
    String refinedWord =
        providedWordToPlay.getFirstWord().upperCaseFirstLetter();

    if (kDebugMode) {
      print("playing word: $refinedWord");
    }
    String fileName = "$refinedWord.mp3";
    final soundFilePath =
        await DirectoryHandler.getLocalResourceFilePath(fileName);
    File file = File(soundFilePath);
    try {
      if (file.existsSync()) {
        await _playLocal(fileName);
        return;
      }
      if (!file.existsSync()) {
        yield false;
        await FileHandler(fileName).downloadToResource(url);
        yield true;
        _playLocal(fileName);
      }
    } catch (e) {
      if (kDebugMode) {
        print("error downloading sound track: $e");
      }
      _playTts(refinedWord);
    }
  }

  Future<bool> _playLocal(String fileName) async {
    try {
      var filePath = await DirectoryHandler.getLocalResourceFilePath(fileName);
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(UrlSource(filePath));
      return true;
    } catch (e) {
      // Play sound using local tts
      _playTts(fileName.substring(0, fileName.indexOf('.')));
      return false;
    }
  }
}