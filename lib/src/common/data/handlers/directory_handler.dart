import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryHandler{
  /// Get default Application Document Directory in the platform
  static Future<String> getLocalResourceFilePath(String fileName) async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/Diccon/Resource/$fileName';
    return filePath;
  }
  static Future<String> getLocalResourcePath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = '${directory.path}/Diccon/Resource';
    return documentPath;
  }

  /// Get default Application Document Directory in the platform
  static Future<String> getLocalUserDataFilePath(String fileName) async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/Diccon/UserData/$fileName';
    return filePath;
  }
  static Future<String> getLocalUserDataPath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = '${directory.path}/Diccon/UserData';
    return documentPath;
  }


  static Future<void> _createDicconDirectoryIfNotExists() async {
    // Get the document directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Create the directory path
    String directoryPath = '${appDocDir.path}/Diccon';
    String userDataPath = '${appDocDir.path}/Diccon/UserData';
    String resourcePath = '${appDocDir.path}/Diccon/Resource';

    // Create the Diccon directory if it doesn't exist
    Directory directory = Directory(directoryPath);
    Directory userData = Directory(userDataPath);
    Directory resource = Directory(resourcePath);
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    if (!await userData.exists()) {
      await userData.create(recursive: true);
    }
    if (!await resource.exists()) {
      await resource.create(recursive: true);
    }
  }
}