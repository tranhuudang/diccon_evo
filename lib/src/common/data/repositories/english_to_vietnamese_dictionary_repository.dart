import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/common/common.dart';

abstract class EnglishToVietnameseDictionaryRepository {
  Future<Word> getDefinition(String word);
  Future<List<String>> getSynonyms(String word);
  Future<List<String>> getAntonyms(String word);
}

class EnglishToVietnameseDictionaryRepositoryImpl implements EnglishToVietnameseDictionaryRepository {
  @override
  Future<List<String>> getSynonyms(String word) async {
    var thesaurus = ThesaurusDatabase.instance;
    var thesaurusDb = await thesaurus.sysnonymsDatabase;
    List<String> synonyms = thesaurusDb[word] ?? [];
    return synonyms.take(Properties.defaultSetting.numberOfSynonyms).toList();
  }

  @override
  Future<List<String>> getAntonyms(String word) async {
    var thesaurus = ThesaurusDatabase.instance;
    var thesaurusDb = await thesaurus.antonymsDatabase;
    List<String> synonyms = thesaurusDb[word] ?? [];
    return synonyms.take(Properties.defaultSetting.numberOfAntonyms).toList();
  }

  @override
  Future<Word> getDefinition(String word) async {
      return await _getDefinitionForAndroidAndWindows(word);
  }
  Future<Word> _getDefinitionForAndroidAndWindows(String word) async {
    var result = await _getResultFromSQLiteDatabase(word);
    if (result != Word.empty()) return result;
    if (_isSEnding(word) || _isDEnding(word)) {
      var cutWord = word.substring(0, word.length - 1);
      result = await _getResultFromSQLiteDatabase(cutWord);
      if (result != Word.empty()) return result;
    } else if (_isEdEnding(word)) {
      var cutWord = word.substring(0, word.length - 2);
      result = await _getResultFromSQLiteDatabase(cutWord);
      if (result != Word.empty()) return result;
    }
    if (kDebugMode) {
      print('Word not found in the dictionary.');
    }
    return Word.empty();
  }

  Future<Word> _getResultFromSQLiteDatabase(String refinedWord) async {
    final dbHelper = EnglishToVietnameseDictionaryDatabase.instance;
    var result = await dbHelper.queryDictionary(refinedWord);
    if (result.isNotEmpty) {
      final definition = result[0]['definition'];
      final pronounce = result[0]['pronounce'];

      // Add the found word to the history file
      HistoryManager.saveWordToHistory(refinedWord.upperCaseFirstLetter());

      return Word(
        word: refinedWord,
        pronunciation: pronounce,
        definition: definition,
      );
    } else {
      // Return an appropriate value when result is empty
      return Word.empty();
    }
  }

  bool _isSEnding(String word) {
    // Remove s in plural word to get the singular word
    if (word.lastIndexOf('s') == (word.length - 1)) {
      if (kDebugMode) {
        print("Remove s in plural word to get the singular word");
      }
      return true;
    }
    return false;
  }

  bool _isDEnding(word) {
    // Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)
    // Remove d in verb in the past Ex: play (chơi) → played (đã chơi)
    if (word.lastIndexOf('d') == (word.length - 1)) {
      if (kDebugMode) {
        print(
            "Remove ed in verb in the past Ex: play (chơi) → played (đã chơi)");
      }
      return true;
    }
    return false;
  }

  bool _isEdEnding(word) {
    // Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)
    if (word.lastIndexOf('ed') == (word.length - 2)) {
      if (kDebugMode) {
        print(
            "Remove d in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)");
      }
      return true;
    }
    return false;
  }
}
