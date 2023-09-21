import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/helpers/file_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../config/properties.dart';
import '../models/article.dart';

class ArticleRepository {
  static Future<List<Article>> getDefaultStories() async {
    String contents = await _getAssetFile('assets/stories/story-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
      return articles;
    } else {
      return [];
    }
  }

  static Future<List<Article>> getOnlineStoryList() async {
    try {
      String filePath =
          await FileHandler(Properties.extendStoryFileName).getLocalFilePath();
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
          var jsonData = await _getJsonFromUrl(
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

  static Future<dynamic> _getJsonFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch JSON from URL');
    }
  }

  /// Read default stories data
  static Future<String> _getAssetFile(String filePath) async {
    return await rootBundle.loadString(filePath);
  }
}
