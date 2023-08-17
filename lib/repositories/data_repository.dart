import 'dart:convert';
import 'package:diccon_evo/interfaces/data.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../properties.dart';
import '../models/article.dart';
import '../models/video.dart';
import '../models/word.dart';

import '../helpers/file_handler.dart';

class DataRepository implements Data {
  @override
  Future<List<Article>> getOnlineStoryList() async {
    try {
      var jsonData = await FileHandler.getJsonFromUrl(
          'https://github.com/tranhuudang/Diccon-Assets/raw/main/stories/extends.json');
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
      print('Error: $e');
      return [];
    }
  }

  @override
  Future<List<Word>> getWordList() async {
    String dataEv = await rootBundle.loadString(Properties.evDataPath);
    String dataVe = await rootBundle.loadString(Properties.veDataPath);
    String data = dataEv + dataVe;
    List<String> wordDataList = data.split('@');
    List<Word> wordList = [];

    for (int i = 1; i < wordDataList.length; i++) {
      String wordData = wordDataList[i];
      List<String> wordParts = wordData.split('*');
      String word = wordParts[0].trim();
      String meaning = wordData.replaceAll(word, '');
      Word newWord = Word(
        word: word,
        meaning: meaning,
      );

      wordList.add(newWord);
    }
    return wordList;
  }

  @override
  Future<List<Article>> getDefaultStories() async {
    String contents =
        await FileHandler.getAssetFile('assets/stories/story-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
      return articles;
    } else {
      return [];
    }
  }

  @override
  Future<List<Video>> getDefaultVideos() async {
    String contents =
    await FileHandler.getAssetFile('assets/videos/video-default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Video> videos =
      json.map((e) => Video.fromJson(e)).toList().cast<Video>();
      return videos;
    } else {
      return [];
    }
  }

  @override
  Future<List<Video>> getOnlineVideosList() async {
    try {
      var jsonData = await FileHandler.getJsonFromUrl(
          'https://github.com/tranhuudang/Diccon-Assets/raw/main/videos/extends.json');
      if (jsonData is List<dynamic>) {
        final List<Video> video =
        jsonData.map((e) => Video.fromJson(e)).toList().cast<Video>();
        return video;
      } else {
        return [];
      }
      // Do something with the jsonData
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error: $e');
      return [];
    }
  }

}
