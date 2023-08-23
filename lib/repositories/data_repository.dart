import 'package:diccon_evo/interfaces/data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../properties.dart';
import '../models/word.dart';
import '../helpers/file_handler.dart';

class DataRepository implements Data {

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
  Future<List<String>> getSuggestionWordList() async {
    try {
      var content = await FileHandler.getAssetFile('assets/dictionary/109k.txt');
      List<String> words = content.split('\n');
      return words;
    } catch (e) {
    if (kDebugMode) {
      print("Error reading file: getSuggestionWordList()");
    }
    return [];
    }
  }

}
