import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../../config/properties.dart';
import '../handlers/directory_handler.dart';

class UserHandler {
  Future uploadUserDataFile(String fileName) async {
    final onlinePath = "${Properties.userInfo.id}/$fileName";
    final localFilePath = await DirectoryHandler.getLocalUserDataFilePath(fileName);
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

  Future _downloadFirebaseFile(Reference ref) async {
    if (kDebugMode) {
      print("Working on ${ref.name}-------------------");
    }
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(ref.name);
    final file = File(filePath);
    if (!file.existsSync()) {
      await ref.writeToFile(file);
      if (kDebugMode) {
        print("Downloaded: ${file.path}");
      }
    } else {
      final tempCloudFilePath = await DirectoryHandler.getLocalUserDataFilePath(ref.name);
      final tempCloudfile = File(tempCloudFilePath);
      await ref.writeToFile(tempCloudfile);
      List<dynamic> cloudJsonFile =
          jsonDecode(File(tempCloudfile.path).readAsStringSync());
      List<dynamic> localJsonFile =
          jsonDecode(File(file.path).readAsStringSync());

      /// Syncing article history and bookmark
      if (ref.name == Properties.articleHistoryFileName ||
          ref.name == Properties.articleBookmarkFileName) {
        for (var article in cloudJsonFile) {
          bool isArticleExist = localJsonFile.any(
              (articleInLocal) => articleInLocal['title'] == article["title"]);
          if (!isArticleExist) {
            if (json is List<dynamic>) {
              localJsonFile.add(article.toJson());
              final encoded = jsonEncode(json);
              await file.writeAsString(encoded);
            }
          }
        }

        /// Syncing word history in dictionary
        if (ref.name == Properties.wordHistoryFileName) {
          for (var word in cloudJsonFile) {
            bool isWordExist = localJsonFile.any(
                (articleInLocal) => articleInLocal['word'] == word["word"]);
            if (!isWordExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(word.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          }
        }

        /// Syncing topic history in 1848 essential
        if (ref.name == Properties.topicHistoryFileName) {
          for (var topic in cloudJsonFile) {
            bool isTopicExist =
                localJsonFile.any((topicInLocal) => topicInLocal == topic);
            if (!isTopicExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(topic.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          }
        }

        /// Syncing word history in dictionary
        if (ref.name == Properties.essentialFavouriteFileName) {
          for (var word in cloudJsonFile) {
            bool isWordExist = localJsonFile.any((articleInLocal) =>
                articleInLocal['english'] == word["english"]);
            if (!isWordExist) {
              if (json is List<dynamic>) {
                localJsonFile.add(word.toJson());
                final encoded = jsonEncode(json);
                await file.writeAsString(encoded);
              }
            }
          }
        }
        file.writeAsStringSync(json.encode(localJsonFile));

        if (kDebugMode) {
          print("Downloaded and merged with local data: ${file.path}");
        }
      }
    }
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
}
