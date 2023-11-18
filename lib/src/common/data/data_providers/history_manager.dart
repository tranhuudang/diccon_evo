import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/common/common.dart';

class HistoryManager {
  /// Convert a [Word] object to Json format before save it to history.json
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  static Future<bool> saveWordToHistory(String word) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(LocalDirectory.wordHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a word is already exists in the history
        bool isWordExists =
        json.any((topicInList) => topicInList == word);
        if (!isWordExists) {
          if (json is List<dynamic>) {
            json.add(word);
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          } else {
            final List<dynamic> list = [json, word];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([word]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save $word to history.json. Error detail: $e");
      }
      return false;
    }
  }

  static Future<bool> removeWordOutOfHistory(String providedWord) async {

    final filePath = await DirectoryHandler.getLocalUserDataFilePath(LocalDirectory.wordHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a word is already exists in the history
        bool isWordExists =
        json.any((word) => word == providedWord);
        if (isWordExists) {
            json.remove(providedWord);
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
            if (kDebugMode) {
              print("Delete word $providedWord");
            }

        }
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't delete $providedWord out of history.json. Error detail: $e");
      }
      return false;
    }
  }

  static Future<List<String>> readWordHistory() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(LocalDirectory.wordHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<String> topics =
          json.cast<String>();
          return topics;
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
  static Future<bool> saveTopicToHistory(String topic) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(LocalDirectory.topicHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a word is already exists in the history
        bool isWordExists =
        json.any((topicInList) => topicInList == topic);
        if (!isWordExists) {
          if (json is List<dynamic>) {
            json.add(topic);
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          } else {
            final List<dynamic> list = [json, topic];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([topic]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save $topic to history.json. Error detail: $e");
      }
      return false;
    }
  }

  static Future<List<String>> readTopicHistory() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(LocalDirectory.topicHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<String> topics =
          json.cast<String>();
          return topics;
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

}