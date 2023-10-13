import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../../config/properties_constants.dart';
import '../models/word.dart';

class DictionaryRepository {

  /// Get list of words with definition in dataset.
  Future<List<Word>> getWordList() async => await _getWordList();

  /// Get list of word without definition in dataset.
  Future<List<String>> getSuggestionWordList() async => await _getSuggestionWordList();

  Future<List<Word>> _getWordList() async {
    String dataEv = await rootBundle.loadString(PropertiesConstants.evDataPath);
    //String dataVe = await rootBundle.loadString(Properties.veDataPath);
    //String data = dataEv + dataVe;
    String data = dataEv;
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

  Future<List<String>> _getSuggestionWordList() async {
    try {
      var content =
       await rootBundle.loadString('assets/dictionary/109k.txt');
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
