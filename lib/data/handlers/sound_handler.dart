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

  void playAnyway() => _playAnyway();
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

  void _playAnyway() async {
    String url = _onlineSoundUrlPath();
    // Okapi /'ou'kɑ:pi/
    String refinedWord =
        providedWordToPlay.getFirstWord().upperCaseFirstLetter();

    if (kDebugMode) {
      print("playing word: $refinedWord");
    }
    String fileName = "$refinedWord.mp3";
    File file = File(await DirectoryHandler.getLocalFilePath(fileName));

    // Check if the file is already downloaded before and play it
    if (await file.exists()) {
      _playLocal(fileName);
      return;
    } else if (await FileHandler(fileName).download(url)) {
      // Try to download if it available on Online Resources
      _playLocal(fileName);
    }
  }

  void _playLocal(String fileName) async {
    try {
      var filePath = await DirectoryHandler.getLocalFilePath(fileName);
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(UrlSource(filePath));
    } catch (e) {
      // Play sound using local tts
      _playTts(fileName.substring(0, fileName.indexOf('.')));
    }
  }
}
