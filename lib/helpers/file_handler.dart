import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/config/properties.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  Future<String> getLocalDocumentPath() async => await getLocalDocumentPath();

  /// Delete a provided file name in local document file path
  ///
  /// Returns a [Boolean] value as true if the process is completed without error.
  Future<bool> deleteFile() async => await _deleteFile();

  Future uploadUserDataFile() async {
    final onlinePath = "${Properties.userInfo.id}/$fileName";
    final localFilePath = await _getLocalFilePath();
    final fileToUpload = File(localFilePath);
    if (fileToUpload.existsSync()) {
      if (kDebugMode) {
        print("Start upload $fileName");
      }
      final ref = FirebaseStorage.instance.ref().child(onlinePath);
      final task = ref.putFile(fileToUpload);
      await task.whenComplete(() {
        if (kDebugMode) {
          print("Upload $fileName completed");
        }
      });
    }
  }

  /// Download all founded user data file in Firebase
  Future downloadUserDataFile() async {
    Future<ListResult> futureFiles =
        FirebaseStorage.instance.ref("/${Properties.userInfo.id}").listAll();
    await futureFiles.then((ListResult fileObjects) {
      List<Reference> files = fileObjects.items;
      for (Reference ref in files) {
        _downloadFirebaseFile(ref);
      }
    });
  }

  /// Delete all founded user data file in Firebase
  Future deleteUserDataFile() async {
    Future<ListResult> futureFiles =
        FirebaseStorage.instance.ref("/${Properties.userInfo.id}").listAll();
    await futureFiles.then((ListResult fileObjects) {
      List<Reference> references = fileObjects.items;
      for (Reference ref in references) {
        ref.delete();
      }
    });
  }


  Future _downloadFirebaseFile(Reference ref) async {
    if (kDebugMode) {
      print("Working on ${ref.name}-------------------");
    }
    final dir = await _getLocalDocumentPath();
    final file = File("$dir/${ref.name}");

    if (!file.existsSync()) {
      await ref.writeToFile(file);
      if (kDebugMode) {
        print("Downloaded: ${file.path}");
      }
    } else {
      final tempCloudfile = File("$dir/temp_${ref.name}");
      await ref.writeToFile(tempCloudfile);
      List<dynamic> cloudJsonFile =
      jsonDecode(File(tempCloudfile.path).readAsStringSync());
      List<dynamic> localJsonFile =
      jsonDecode(File(file.path).readAsStringSync());

      /// Syncing article history and bookmark
      if (ref.name == Properties.articleHistoryFileName ||
          ref.name == Properties.articleBookmarkFileName) {
        cloudJsonFile.forEach((article) async {
          bool isArticleExist = localJsonFile.any(
                  (articleInLocal) =>
              articleInLocal['title'] == article["title"]);
          if (!isArticleExist) {
            if (json is List<dynamic>) {
              localJsonFile.add(article.toJson());
              final encoded = jsonEncode(json);
              await file.writeAsString(encoded);
            }
          }
        });

        /// Syncing word history in dictionary
        if (ref.name == Properties.wordHistoryFileName) {
          cloudJsonFile.forEach((word) async {
            bool isWordExist = localJsonFile.any(
                    (articleInLocal) => articleInLocal['word'] == word["word"]);
            if (!isWordExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(word.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          });
        }
        /// Syncing topic history in 1848 essential
        if (ref.name == Properties.topicHistoryFileName) {
          cloudJsonFile.forEach((topic) async {
            bool isTopicExist = localJsonFile.any(
                    (topicInLocal) => topicInLocal == topic);
            if (!isTopicExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(topic.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          });
        }
        /// Syncing word history in dictionary
        if (ref.name == Properties.essentialFavouriteFileName) {
          cloudJsonFile.forEach((word) async {
            bool isWordExist = localJsonFile.any(
                    (articleInLocal) => articleInLocal['english'] == word["english"]);
            if (!isWordExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(word.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          });
        }
        file.writeAsStringSync(json.encode(localJsonFile));

        if (kDebugMode) {
          print("Downloaded and merged with local data: ${file.path}");
        }
      }
    }
  }
  Future<bool> _downloadFile(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await _getLocalFilePath();
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

  Future<String> _getLocalDocumentPath() async {
    await _createDicconDirectoryIfNotExists();
    var directory = await getApplicationDocumentsDirectory();
    var documentPath = '${directory.path}/Diccon';
    return documentPath;
  }

  Future<bool> _deleteFile() async {
    final filePath = await _getLocalFilePath();
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
