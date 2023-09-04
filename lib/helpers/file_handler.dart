import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileHandler {
  final String fileName;
  FileHandler(this.fileName);


  /// Download provided [fileName] from a [url] and save it to default Application Document Directory in the platform
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  Future<bool> downloadFile(String url) async => await _downloadFile(url);

  /// Get default Application Document Directory in the platform
  Future<String> getLocalFilePath() async => await _getLocalFilePath();

  /// Delete a provided file name in local document file path
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  Future<bool> deleteFile() async => await _deleteFile();

  Future<bool> _downloadFile(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await getLocalFilePath();
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> _getLocalFilePath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/Diccon/$fileName';
    return filePath;
  }

  Future<bool> _deleteFile() async {
    final filePath = await getLocalFilePath();
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

  Future<void> _createDicconDirectoryIfNotExists() async {
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
