import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/models/essential_word.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'file_handler.dart';

class EssentialManager {




  static Future<List<EssentialWord>> loadEssentialData(String topic) async {
    final jsonString = await rootBundle
        .loadString('assets/essential/3000_essential_words.json');
    final jsonData = json.decode(jsonString);
    List<EssentialWord> essentialWords = [];

    for (var essentialData in jsonData[topic]!) {
      essentialWords.add(EssentialWord.fromJson(essentialData));
    }
    return essentialWords;
  }

  static Future<List<EssentialWord>> readFavouriteEssential() async {
    final filePath = await FileHandler("essential_favourite.json").getLocalFilePath();
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<EssentialWord> words =
          json.map((e) => EssentialWord.fromJson(e)).toList().cast<EssentialWord>();
          return words;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Can't read history.json. Error detail: $e");
      }
      return [];
    }
  }


  static Future<bool> saveEssentialWordToFavourite(EssentialWord word) async {
    final filePath = await FileHandler("essential_favourite.json")
        .getLocalFilePath();
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a word is already exists in the history
        bool isWordExists =
        json.any((wordInList) => wordInList['english'] == word.english);
        if (!isWordExists) {
          if (json is List<dynamic>) {
            json.add(word.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
            print("favourite added");
          } else {
            final List<dynamic> list = [json, word.toJson()];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
            print("favourite added");
          }
        }
      } else {
        final encoded = jsonEncode([word.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save ${word
            .english} to essential_favourite.json. Error detail: $e");
      }
      return false;
    }
  }

  static removeAWordOutOfFavourite(String wordEnglishName) async {
    final filePath = await FileHandler("essential_favourite.json")
        .getLocalFilePath();
    try {
      final file = File(filePath);
      if (await file.exists()
      ) {
        final contents = await file.readAsString();
        // Parse the JSON string into a Dart list
        List<Map<String, dynamic>> jsonList = json.decode(contents).cast<
            Map<String, dynamic>>();

        // Filter the list to remove the object with the specified condition
        jsonList.removeWhere((item) => item['english'] == wordEnglishName);

        // Convert the filtered list back into a JSON string
        String updatedJsonData = json.encode(jsonList);
        await file.writeAsString(updatedJsonData);
        // Print the updated JSON string
        print(updatedJsonData);
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            "Can't remove a word out of essential_favourite.json. Error detail: $e");
      }
    }
  }
}