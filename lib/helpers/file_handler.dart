import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/properties.dart';
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
    await createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/Diccon/$fileName';
    return filePath;
  }

  /// Convert a [Word] object to Json format before save it to history.json
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  static Future<bool> saveWordToHistory(Word word) async {
    final filePath = await getLocalFilePath(Properties.wordHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a word is already exists in the history
        bool isWordExists =
            json.any((wordInList) => wordInList['word'] == word.word);
        if (!isWordExists) {
          if (json is List<dynamic>) {
            json.add(word.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          } else {
            final List<dynamic> list = [json, word.toJson()];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
          }
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

  /// Delete a provided file name in local document file path
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  static Future<bool> deleteFile(String fileName) async {
    final filePath = await getLocalFilePath(fileName);
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

  static Future<List<Word>> readWordHistory() async {
    final filePath = await getLocalFilePath(Properties.wordHistoryFileName);
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
      // If the request is successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch JSON from URL');
    }
  }

  static Future<void> createDicconDirectoryIfNotExists() async {
    // Get the document directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Create the directory path
    String directoryPath = '${appDocDir.path}/Diccon';

    // Create the directory if it doesn't exist
    Directory directory = Directory(directoryPath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
  }
}
