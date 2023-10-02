import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/data/handlers/file_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config/properties.dart';
import '../handlers/directory_handler.dart';
import '../helpers/file_helper.dart';
import '../models/story.dart';

class StoryRepository {
   Future<List<Story>> getDefaultStories() async {
    String contents = await FileHelper.getAssetFile('assets/stories/story-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Story> stories =
          json.map((e) => Story.fromJson(e)).toList().cast<Story>();
      return stories;
    } else {
      return [];
    }
  }

   Future<List<Story>> getOnlineStoryList() async {
    try {
      String filePath =
          await DirectoryHandler.getLocalUserDataFilePath(Properties.extendStoryFileName);
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
            final List<Story> stories = jsonData
                .map((e) => Story.fromJson(e))
                .toList()
                .cast<Story>();

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

   Future<List<Story>> readStoryHistory() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.storyHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<Story> stories =
          json.map((e) => Story.fromJson(e)).toList().cast<Story>();
          return stories;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Can't read story history.json. Error detail: $e");
      }
      return [];
    }
  }

   Future<List<Story>> readStoryBookmark() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.storyBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<Story> stories =
          json.map((e) => Story.fromJson(e)).toList().cast<Story>();
          return stories;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Can't read story history.json. Error detail: $e");
      }
      return [];
    }
  }

   Future<bool> saveReadStoryToHistory(Story story) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.storyHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a story is already exists in the history
        bool isStoryExist = json
            .any((storyInJson) => storyInJson['title'] == story.title);
        if (!isStoryExist) {
          if (json is List<dynamic>) {
            json.add(story.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          } else {
            final List<dynamic> list = [json, story.toJson()];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([story.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save to story history.json. Error detail: $e");
      }
      return false;
    }
  }

   Future<bool> saveReadStoryToBookmark(Story story) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.storyBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a story is already exists in the history
        bool isStoryExist = json
            .any((storyInJson) => storyInJson['title'] == story.title);
        if (!isStoryExist) {
          if (json is List<dynamic>) {
            json.add(story.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([story.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save to story history.json. Error detail: $e");
      }
      return false;
    }
  }

  Future<bool> deleteAllStoryHistory() async{
   return await FileHandler(Properties.storyHistoryFileName).deleteOnUserData();
  }
   Future<bool> deleteAllStoryBookmark() async{
     return await FileHandler(Properties.storyBookmarkFileName).deleteOnUserData();
   }

}
