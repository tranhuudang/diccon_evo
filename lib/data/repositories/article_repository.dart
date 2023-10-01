import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/data/handlers/file_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../config/properties.dart';
import '../handlers/directory_handler.dart';
import '../helpers/file_helper.dart';
import '../models/article.dart';

class ArticleRepository {
   Future<List<Article>> getDefaultStories() async {
    String contents = await FileHelper.getAssetFile('assets/stories/story-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
      return articles;
    } else {
      return [];
    }
  }

   Future<List<Article>> getOnlineStoryList() async {
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
            final List<Article> articles = jsonData
                .map((e) => Article.fromJson(e))
                .toList()
                .cast<Article>();

            return articles;
          } else {
            return [];
          }
        } else {
          if (kDebugMode) {
            print(
                "we have error while trying to get extend article with status code from http is: ${response.statusCode}");
          }
          return [];
        }
      } else {
        if (kDebugMode) {
          print("get article from extend-story.json in local");
        }
        var stringData = file.readAsStringSync();
        var jsonData = json.decode(stringData);
        if (jsonData is List<dynamic>) {
          final List<Article> articles =
              jsonData.map((e) => Article.fromJson(e)).toList().cast<Article>();

          return articles;
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

   Future<List<Article>> readArticleHistory() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.articleHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
          return articles;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Can't read article history.json. Error detail: $e");
      }
      return [];
    }
  }

   Future<List<Article>> readArticleBookmark() async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.articleBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        if (json is List<dynamic>) {
          final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
          return articles;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      if (kDebugMode) {
        print("Can't read article history.json. Error detail: $e");
      }
      return [];
    }
  }

   Future<bool> saveReadArticleToHistory(Article article) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.articleHistoryFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a article is already exists in the history
        bool isArticleExist = json
            .any((articleInJson) => articleInJson['title'] == article.title);
        if (!isArticleExist) {
          if (json is List<dynamic>) {
            json.add(article.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          } else {
            final List<dynamic> list = [json, article.toJson()];
            final encoded = jsonEncode(list);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([article.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save to article history.json. Error detail: $e");
      }
      return false;
    }
  }

   Future<bool> saveReadArticleToBookmark(Article article) async {
    final filePath = await DirectoryHandler.getLocalUserDataFilePath(Properties.articleBookmarkFileName);
    try {
      final file = File(filePath);
      if (await file.exists()) {
        final contents = await file.readAsString();
        final json = jsonDecode(contents);
        // Check is a article is already exists in the history
        bool isArticleExist = json
            .any((articleInJson) => articleInJson['title'] == article.title);
        if (!isArticleExist) {
          if (json is List<dynamic>) {
            json.add(article.toJson());
            final encoded = jsonEncode(json);
            await file.writeAsString(encoded);
          }
        }
      } else {
        final encoded = jsonEncode([article.toJson()]);
        await file.writeAsString(encoded);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print("Can't save to article history.json. Error detail: $e");
      }
      return false;
    }
  }

  Future<bool> deleteAllArticleHistory() async{
   return await FileHandler(Properties.articleHistoryFileName).deleteOnUserData();
  }
   Future<bool> deleteAllArticleBookmark() async{
     return await FileHandler(Properties.articleBookmarkFileName).deleteOnUserData();
   }

}
