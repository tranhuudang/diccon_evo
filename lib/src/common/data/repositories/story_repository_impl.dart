import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../helpers/file_helper.dart';
import 'package:diccon_evo/src/common/common.dart';


class StoryRepositoryImpl implements StoryRepository{
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
  Future<List<Story>> readStoryHistory() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(
        LocalDirectory.storyHistoryFileName);
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

  @override
  Future<List<Story>> readStoryBookmark() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(
        LocalDirectory.storyBookmarkFileName);
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

  @override
  Future<bool> saveReadStoryToHistory(Story story) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(
        LocalDirectory.storyHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a story is already exists in the history
        bool isStoryExist =
            json.any((storyInJson) => storyInJson['title'] == story.title);
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

  @override
  Future<bool> saveReadStoryToBookmark(Story story) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(
        LocalDirectory.storyBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a story is already exists in the history
        bool isStoryExist =
            json.any((storyInJson) => storyInJson['title'] == story.title);
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

  @override
  Future<bool> removeAStoryInBookmark(Story story) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(
        LocalDirectory.storyBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        List<dynamic> json = jsonDecode(contents).toList();
        // Check is a story is already exists in the bookmark
        bool isStoryExist =
            json.any((storyInJson) => storyInJson['title'] == story.title);
        if (isStoryExist) {

          json.removeWhere((storyInJson) => storyInJson['title'] == story.title);
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
            if (kDebugMode) {
              print("Remove a story out of ${LocalDirectory.storyBookmarkFileName}");
            }
        }
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print(
            "Can't remove to story ${LocalDirectory.storyBookmarkFileName}. Error detail: $e");
      }
      return false;
    }
  }

  @override
  Future<bool> deleteAllStoryHistory() async {
    return await FileHandler(LocalDirectory.storyHistoryFileName)
        .deleteOnUserData();
  }

  @override
  Future<bool> deleteAllStoryBookmark() async {
    return await FileHandler(LocalDirectory.storyBookmarkFileName)
        .deleteOnUserData();
  }
}

