import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:diccon_evo/common/common.dart';
import '../models/essential_word.dart';

class EssentialWordRepository {

  static Future<List<EssentialWord>> loadEssentialData(String topic) async {
    final jsonString = await rootBundle
        .loadString(PropertiesConstants.essentialWordFileName);
    final jsonData = json.decode(jsonString);
    List<EssentialWord> essentialWords = [];

    for (var essentialData in jsonData[topic]!) {
      essentialWords.add(EssentialWord.fromJson(essentialData));
    }
    return essentialWords;
  }

  static Future<List<EssentialWord>> readFavouriteEssential() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(PropertiesConstants.essentialFavouriteFileName);
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
    final filePath = await DirectoryHandler
        .getLocalUserDataFilePath(PropertiesConstants.essentialFavouriteFileName);
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
            if (kDebugMode) {
              print("favourite added");
            }
          } else {
            final List<dynamic> list = [json, word.toJson()];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
            if (kDebugMode) {
              print("favourite added");
            }
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

  static removeEssentialWordOutOfFavourite(EssentialWord word) async {
    final filePath = await DirectoryHandler
        .getLocalUserDataFilePath(PropertiesConstants.essentialFavouriteFileName);
    try {
      final file = File(filePath);
      if (await file.exists()
      ) {
        final contents = await file.readAsString();
        // Parse the JSON string into a Dart list
        List<Map<String, dynamic>> jsonList = json.decode(contents).cast<
            Map<String, dynamic>>();

        // Filter the list to remove the object with the specified condition
        jsonList.removeWhere((item) => item['english'] == word.english);

        // Convert the filtered list back into a JSON string
        String updatedJsonData = json.encode(jsonList);
        await file.writeAsString(updatedJsonData);
        // Print the updated JSON string
        if (kDebugMode) {
          print("${word.english} is removed out of essential favourite list");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(
            "Can't remove a word out of essential_favourite.json. Error detail: $e");
      }
    }
  }
}