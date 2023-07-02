import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/global.dart';
import 'package:diccon_evo/models/article.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../models/word.dart';

class FileHandler {
  /// Download provided [fileName] from a [url] and save it to default Application Document Directory in the platform
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  static Future<bool> downloadFile(String url, String fileName) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await getLocalFilePath(fileName);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  /// Get default Application Document Directory in the platform
  static Future<String> getLocalFilePath(String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    return filePath;
  }

  /// Convert a [Word] object to Json format before save it to history.json
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  static Future<bool> saveToHistory(Word word) async {
    final filePath = await getLocalFilePath(Global.HISTORY_FILENAME);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          json.add(word.toJson());
          final encoded = jsonEncode(json);
          await file.writeAsString(encoded);
        } else {
          final List<dynamic> list = [json, word.toJson()];
          final encoded = jsonEncode(list);
          await file.writeAsString(encoded);
        }
      } else {
        final encoded = jsonEncode([word.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save ${word.word} to history.json. Error detail: $e");
      }
      return false;
    }
  }


  static Future<bool> clearHistory() async {
    final filePath = await getLocalFilePath(Global.HISTORY_FILENAME);
    try {
      final file = File(filePath);
      file.delete();
      if (kDebugMode) {
        print('Text file cleared successfully.');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to clear text file: $e');
      }
      return false;
    }
  }

  static Future<List<Word>> readHistory() async {
    final filePath = await getLocalFilePath(Global.HISTORY_FILENAME);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<Word> words =
          json.map((e) => Word.fromJson(e)).toList().cast<Word>();
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

  /// Read default stories data
  static Future<String> getAssetFile(String filePath) async {
    return await rootBundle.loadString(filePath);
  }

  static Future<dynamic> getJsonFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      print(response.body);
      // If the request is successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch JSON from URL');
    }
  }


}
