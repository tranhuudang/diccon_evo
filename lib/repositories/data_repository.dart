import 'dart:convert';
import 'package:diccon_evo/interfaces/data.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../global.dart';
import '../models/article.dart';
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
    String dataEv = await rootBundle.loadString(Global.EV_DATA_PATH);
    String dataVe = await rootBundle.loadString(Global.VE_DATA_PATH);
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
        await FileHandler.getAssetFile('assets/stories/default.json');
    final json = jsonDecode(contents);
    if (json is List<dynamic>) {
      final List<Article> articles =
          json.map((e) => Article.fromJson(e)).toList().cast<Article>();
      return articles;
    } else {
      return [];
    }
  }
}
