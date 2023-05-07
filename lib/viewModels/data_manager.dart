import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../models/word.dart';


Future<List<Word>> getWordList() async {
  String type = '';
  String data = await rootBundle.loadString('assets/dictionary/diccon_ev.txt');

  List<String> wordDataList = data.split('@');

  List<Word> wordList = [];

  for (int i = 1; i < wordDataList.length; i++) {
  //for (int i = 1; i < 4; i++) {
    String wordData = wordDataList[i];
    List<String> wordParts = wordData.split('*');
    String word = wordParts[0].trim();

    // if(wordParts[1] != null) {
    //   List<String> typeParts = wordParts[1].split('\n');
    //   type = typeParts[0].trim();
    // }
    String meaning = wordData.replaceAll(word, '');

    Word newWord = Word(
      word: word,
      meaning: meaning,
    );

    wordList.add(newWord);
  }

  return wordList;
}
