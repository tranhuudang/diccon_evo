import 'package:flutter/services.dart' show rootBundle;
import 'package:diccon_evo/src/common/common.dart';

class DictionaryDatabaseWindows {
  DictionaryDatabaseWindows._();
  static final DictionaryDatabaseWindows instance =
      DictionaryDatabaseWindows._();

  Future<List<Word>> get database async {
    if (_database.isNotEmpty) return _database;
    // if not exist database
    _database = await _initDb();
    return _database;
  }

  List<Word> _database = [];

  Future<List<Word>> _initDb() async {
    if (_database.isNotEmpty) return _database;
    _database = await _getWordList();
    return _database;
  }

  Future<List<Word>> _getWordList() async {
    String data = await rootBundle.loadString(PropertiesConstants.evDataPath);
    List<String> wordDataList = data.split('@');
    List<Word> wordList = [];

    for (int i = 1; i < wordDataList.length; i++) {
      String wordData = wordDataList[i];
      List<String> wordParts = wordData.split('*');
      String word = wordParts[0].trim();
      String meaning = wordData.replaceAll(word, '');
      Word newWord = Word(
        word: word,
        definition: meaning,
      );

      wordList.add(newWord);
    }
    return wordList;
  }
}
