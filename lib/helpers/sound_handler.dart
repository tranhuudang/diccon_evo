import 'dart:io';

import 'package:diccon_evo/helpers/file_handler.dart';
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
    String afterFirstLetter = word
        .substring(1, !word.contains(" ") ? word.length - 1 : word.indexOf(" "))
        .toLowerCase();
    String url =
        "https://github.com/zeroclubvn/US-Pronunciation/raw/main/$firstLetter/us/$firstLetter$afterFirstLetter.mp3";

    return url;
  }

  static void playAnyway(String word) async {
    print(word);
    String url = onlineSoundUrlPath(word);
    String firstLetter = word.substring(0, 1).toUpperCase();
    String afterFirstLetter = word
        .substring(1, !word.contains(" ") ? word.length : word.indexOf(" "))
        .toLowerCase();
    String fileName = "$firstLetter$afterFirstLetter.mp3";
    File file = File(await FileHandler.getLocalFilePath(fileName));

    // Check if the file is already downloaded before and play it
    if (await file.exists()) {
      playLocal(fileName);
      return;
    } else if (await FileHandler.downloadFile(url, fileName)) {
      // Try to download if it available on Online Resources
      playLocal(fileName);
    }
  }

  static void playLocal(String fileName) async {
    try {
      var filePath = await FileHandler.getLocalFilePath(fileName);
      AudioPlayer audioPlayer = AudioPlayer();
      await audioPlayer.play(UrlSource(filePath));
    } catch (e) {
      // Play sound using local tts
      playTts(fileName.substring(0, fileName.indexOf('.')));
    }
  }
}
