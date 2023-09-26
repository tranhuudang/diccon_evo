import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DirectoryHandler{
  /// Get default Application Document Directory in the platform
  static Future<String> getLocalFilePath(String fileName) async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/Diccon/$fileName';
    return filePath;
  }
  static Future<String> getLocalDocumentPath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = '${directory.path}/Diccon';
    return documentPath;
  }
  static Future<void> _createDicconDirectoryIfNotExists() async {
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