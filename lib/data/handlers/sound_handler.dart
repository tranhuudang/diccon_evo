import 'dart:io';
import 'package:diccon_evo/extensions/string.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'directory_handler.dart';
import 'file_handler.dart';

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
    String refinedWord = providedWordToPlay.upperCaseFirstLetter();

    if (kDebugMode) {
      print("playing word: $refinedWord");
    }
    String fileName = "$refinedWord.mp3";
    final soundFilePath = await DirectoryHandler.getLocalResourceFilePath(fileName);
    File file = File(soundFilePath);

    try {
      if (await file.exists()) {
        _playLocal(fileName);
      } else {
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


  void _playLocal(String fileName) async {
    try {
      var filePath = await DirectoryHandler.getLocalResourceFilePath(fileName);
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(UrlSource(filePath));
    } catch (e) {
      // Play sound using local tts
      _playTts(fileName.substring(0, fileName.indexOf('.')));
    }
  }
}
