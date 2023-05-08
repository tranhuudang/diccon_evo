import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../global.dart';
import '../models/word.dart';

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
