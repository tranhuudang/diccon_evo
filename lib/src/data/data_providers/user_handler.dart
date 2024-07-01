import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import '../data.dart';
class UserHandler {
  User? currentUser = FirebaseAuth.instance.currentUser;
  Future uploadUserDataFile(String fileName) async {
    final onlinePath = "users/${currentUser?.uid}/$fileName";
    final localFilePath =
        await DirectoryHandler.getLocalUserDataFilePath(fileName);
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
    ListResult futureFiles = await FirebaseStorage.instance
        .ref("users/${currentUser?.uid}")
        .listAll();
    List<Reference> files = futureFiles.items;
    for (Reference ref in files) {
      _downloadFirebaseFile(ref);
    }
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
      final tempCloudFilePath =
          await DirectoryHandler.getLocalUserDataFilePath(ref.name);
      final tempCloudfile = File(tempCloudFilePath);
      await ref.writeToFile(tempCloudfile);
    }
  }

  /// Delete all founded user data file in Firebase
  Future deleteUserDataFile() async {
    Future<ListResult> futureFiles =
        FirebaseStorage.instance.ref("/${currentUser?.uid}").listAll();
    await futureFiles.then((ListResult fileObjects) {
      List<Reference> references = fileObjects.items;
      for (Reference ref in references) {
        ref.delete();
      }
    });
  }
}
