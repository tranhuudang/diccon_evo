import 'dart:io';

import 'package:diccon_evo/viewModels/file_handler.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:audioplayers/audioplayers.dart';

class SoundHandler {
  static void playTts(String word) async {
    FlutterTts tts = FlutterTts();
    await tts.setLanguage('en-US');
    await tts.setPitch(1.0);
    await tts.setSpeechRate(0.5);
    await tts.speak(word);
  }

  static String onlineSoundUrlPath(String word) {
    // Sample link's format: https://github.com/zeroclubvn/US-Pronunciation/raw/main/A/us/Affected.mp3
    String firstLetter = word.substring(0, 1).toUpperCase();
    String afterFirstLetter =
        word.substring(1, word.indexOf(" ")).toLowerCase();
    String url =
        "https://github.com/zeroclubvn/US-Pronunciation/raw/main/$firstLetter/us/$firstLetter$afterFirstLetter.mp3";
    return url;
  }

  static void playOnline(String word) async {
    String url = onlineSoundUrlPath(word);
    String firstLetter = word.substring(0, 1).toUpperCase();
    String afterFirstLetter =
        word.substring(1, word.indexOf(" ")).toLowerCase();
    String fileName = "$firstLetter$afterFirstLetter.mp3";
    String properWord = "$firstLetter$afterFirstLetter";
    File file = File(await FileHandler.getLocalFilePath(fileName));
    // Check if the file is already downloaded before and play it
    if (await file.exists()) {
      playLocal(fileName);
      return;
    } else if (await FileHandler.downloadFile(url, fileName)) {
      // Try to download if it available on Online Resources
      playLocal(fileName);
    } else {
      // Play sound using local tts
      playTts(properWord);
    }
  }

  static void playLocal(String fileName) async {
    var filePath = await FileHandler.getLocalFilePath(fileName);
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(UrlSource(filePath));
  }
}
