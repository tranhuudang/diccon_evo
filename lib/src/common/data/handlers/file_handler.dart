import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'directory_handler.dart';

class FileHandler {
  final String fileName;
  FileHandler(this.fileName);

  Future<bool> downloadToResources(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await DirectoryHandler.getLocalResourcesFilePath(fileName);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteOnResources() async {
    final filePath = await DirectoryHandler.getLocalResourcesFilePath(fileName);
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        file.delete();
        if (kDebugMode) {
          print('File name: $fileName cleared successfully.');
        }
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to clear text file: $fileName');
      }
      return false;
    }
  }
  Future<bool> downloadToUserData(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await DirectoryHandler.getLocalUserDataFilePath(fileName);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      return false;
    }
  }
  Future<bool> deleteOnUserData() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(fileName);
    try {
      final file = File(filePath);
      if (file.existsSync()) {
        file.delete();
        if (kDebugMode) {
          print('File name: $fileName cleared successfully.');
        }
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to clear text file: $fileName');
      }
      return false;
    }
  }
}
