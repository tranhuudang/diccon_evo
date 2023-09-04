import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../helpers/file_handler.dart';
import '../models/article.dart';

class ArticleRepository{
  static Future<List<Article>> getDefaultStories() async {
    String contents =
    await _getAssetFile('assets/stories/story-default.json');
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
      var jsonData = await _getJsonFromUrl(
          'https://github.com/tranhuudang/diccon_assets/raw/main/stories/extends.json');
      if (jsonData is List<dynamic>) {
        final List<Article> articles =
        jsonData.map((e) => Article.fromJson(e)).toList().cast<Article>();
        return articles;
      } else {
        return [];
      }
      // Do something with the jsonData
    } catch (e) {
      // Handle any errors that occur during the fetch
      if (kDebugMode) {
        print('Error: getOnlineStoryList()');
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