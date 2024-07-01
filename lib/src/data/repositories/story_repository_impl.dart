import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../core/core.dart';
import '../../core/utils/md5_generator.dart';
import '../../domain/domain.dart';
import '../data.dart';
import '../helpers/file_helper.dart';

class StoryRepositoryImpl implements StoryRepository {
  @override
  Future<List<Story>> getDefaultStories() async {
    String contents =
        await FileHelper.getAssetFile('assets/stories/story-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Story> stories =
          json.map((e) => Story.fromJson(e)).toList().cast<Story>();
      return stories;
    } else {
      return [];
    }
  }

  @override
  Future<List<Story>> getOnlineStoryList() async {
    try {
      String filePath = await DirectoryHandler.getLocalUserDataFilePath(
          LocalDirectory.extendStoryFileName);
      File file = File(filePath);
      if (!file.existsSync()) {
        if (kDebugMode) {
          print(
              "extend-story.json is not exist, starts to download and saves it to local");
        }

        final response = await http.get(Uri.parse(
            'https://github.com/tranhuudang/diccon_assets/raw/main/stories/extends.json'));
        if (response.statusCode == 200) {
          await file.writeAsString(response.body);
          json.decode(response.body);
          var jsonData = await FileHelper.getJsonFromUrl(
              'https://github.com/tranhuudang/diccon_assets/raw/main/stories/extends.json');

          if (jsonData is List<dynamic>) {
            final List<Story> stories =
                jsonData.map((e) => Story.fromJson(e)).toList().cast<Story>();

            return stories;
          } else {
            return [];
          }
        } else {
          if (kDebugMode) {
            print(
                "we have error while trying to get extend story with status code from http is: ${response.statusCode}");
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print("get story from extend-story.json in local");
        }
        var stringData = file.readAsStringSync();
        var jsonData = json.decode(stringData);
        if (jsonData is List<dynamic>) {
          final List<Story> stories =
              jsonData.map((e) => Story.fromJson(e)).toList().cast<Story>();

          return stories;
        } else {
          return [];
        }
      }

      // Do something with the jsonData
    } catch (e) {
      // Handle any errors that occur during the fetch
      if (kDebugMode) {
        print('Error: getOnlineStoryList()');
        print(e);
      }
      return [];
    }
  }

  @override
  Future<List<Story>> getStoryHistory() async {
    List<Story> result = [];
    final stories = await getDefaultStories();
    final List<String> listStoryMd5 = [];
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      DebugLog.info("Can't get story history because user is not login.");
    } else {
      final collectionRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Story');

      final docSnapshot = await collectionRef.get();
      for (var doc in docSnapshot.docs) {
        listStoryMd5.add(doc.id);
      }
      // This stopIndex used to stop looping check when all needed to find stories is found.
      int stopIndex = 0;
      result = stories.where((story) {
        if (stopIndex >= listStoryMd5.length) return false;
        bool isHaving = listStoryMd5.contains(
            Md5Generator.composeMd5IdForStoryFirebaseDb(
                sentence: story.shortDescription));
        if (isHaving) stopIndex++;
        return isHaving;
      }).toList();
    }
    return result;
  }

  @override
  Future<List<Story>> getStoryBookmark() async {
    List<Story> result = [];
    final stories = await getDefaultStories();
    final List<String> listStoryMd5 = [];
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      DebugLog.info("Can't get story history because user is not login.");
    } else {
      final collectionRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Story');

      final docSnapshot = await collectionRef.get();
      for (var doc in docSnapshot.docs) {
        if (doc.data().containsKey('isBookmark')) {
          if (doc['isBookmark'] == true) {
            listStoryMd5.add(doc.id);
          }
        }
      }

      // This stopIndex used to stop looping check when all needed to find stories is found.
      int stopIndex = 0;
      result = stories.where((story) {
        if (stopIndex >= listStoryMd5.length) return false;
        bool isHaving = listStoryMd5.contains(
            Md5Generator.composeMd5IdForStoryFirebaseDb(
                sentence: story.shortDescription));
        if (isHaving) stopIndex++;
        return isHaving;
      }).toList();
    }
    return result;
  }

  @override
  Future<bool> saveReadStoryToBookmark(Story story) async {
    // todo:
    return true;
  }

  @override
  Future<bool> removeAStoryInBookmark(Story story) async {
    // todo
    return true;
  }

  @override
  Future<bool> deleteAllStoryHistory() async {
    // todo : implement new delete function for story history
    return true;
  }

  @override
  Future<bool> deleteAllStoryBookmark() async {
    // todo:
    return true;
  }
}
