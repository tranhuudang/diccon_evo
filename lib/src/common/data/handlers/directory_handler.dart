import 'dart:io';
import 'package:diccon_evo/src/common/common.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DirectoryHandler {
  /// Get default Application Document Directory in the platform
  static Future<String> getLocalResourcesFilePath(String fileName) async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = join(directory.path, LocalDirectory.rootFolderName,
        LocalDirectory.resourcesDataFolderName, fileName);
    return filePath;
  }

  static Future<String> getLocalResourcesPath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = join(directory.path, LocalDirectory.rootFolderName,
        LocalDirectory.resourcesDataFolderName);
    return documentPath;
  }

  /// Get default Application Document Directory in the platform
  static Future<String> getLocalUserDataFilePath(String fileName) async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var filePath = join(directory.path, LocalDirectory.rootFolderName,
        LocalDirectory.userDataFolderName, fileName);
    return filePath;
  }

  static Future<String> getLocalUserDataPath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = join(directory.path, LocalDirectory.rootFolderName,
        LocalDirectory.userDataFolderName);
    return documentPath;
  }

  static Future<void> _createDicconDirectoryIfNotExists() async {
    // Get the document directory
    Directory appDocDir = await getApplicationDocumentsDirectory();

    // Create the directory path
    String userDataPath = join(appDocDir.path, LocalDirectory.rootFolderName,
        LocalDirectory.userDataFolderName);
    String resourcesPath = join(appDocDir.path, LocalDirectory.rootFolderName,
        LocalDirectory.resourcesDataFolderName);

    // Create the Diccon directory if it doesn't exist
    Directory userData = Directory(userDataPath);
    Directory resources = Directory(resourcesPath);
    if (!await userData.exists()) {
      await userData.create(recursive: true);
    }
    if (!await resources.exists()) {
      await resources.create(recursive: true);
    }
  }
}
