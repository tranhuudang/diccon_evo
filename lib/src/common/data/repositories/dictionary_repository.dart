import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/common/common.dart';

abstract class DictionaryRepository {
  Future<Word> getDefinition(String word);
  Future<List<String>> getSynonyms(String word);
  Future<List<String>> getAntonyms(String word);
}

class DictionaryRepositoryImpl implements DictionaryRepository {
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
    if (defaultTargetPlatform.isAndroid()) {
      if (kDebugMode) {
        print("Get result from AndroidEngine using SQLite");
      }
      return await _getDefinitionForAndroid(word);
    } else if (defaultTargetPlatform.isWindows()) {
      if (kDebugMode) {
        print("Get result from WindowsEngine using Classic Text Search");
      }
      return await _getDefinitionForWindows(word);
    } else {
      return await _getDefinitionForWindows(word);
    }
  }

  Future<Word> _getDefinitionForWindows(String searchWord) async {
    final db = DictionaryDatabaseWindows.instance;
    final wordList = await db.database;
    var refineWord = searchWord.removeSpecialCharacters().trim().toLowerCase();

    if (kDebugMode) {
      print("refined word:[$refineWord]");
    }
    for (int i = 0; i < wordList.length; i++) {
      String word = wordList[i].word;

      if (word == refineWord) {
        if (kDebugMode) {
          print("Start to get the value that completely match with user input");
        }

        // Add found word to history file
        await HistoryManager.saveWordToHistory(
            refineWord.upperCaseFirstLetter());
        return wordList[i];
      } else

      // Start to get the value that completely match with user input
      if (word.startsWith("$refineWord${PropertiesConstants.blankSpace}")) {
        if (kDebugMode) {
          print("Start to get the value that completely match with user input");
        }

        // Add found word to history file
        await HistoryManager.saveWordToHistory(
            refineWord.upperCaseFirstLetter());
        return wordList[i];
      }
    }
    for (int i = 0; i < wordList.length; i++) {
      String word = wordList[i].word;

      // Remove s in plural word to get the singular word
      if (word.startsWith(refineWord.substring(0, refineWord.length - 1)) &&
          (refineWord.lastIndexOf('s') == (refineWord.length - 1))) {
        if (kDebugMode) {
          print("Remove s in plural word to get the singular word");
        }

        // Add found word to history file
        await HistoryManager.saveWordToHistory(
            refineWord.upperCaseFirstLetter());
        return wordList[i];
      } else
      // Remove d in verb in the past Ex: play (chơi) → played (đã chơi)
      if (word.startsWith(refineWord.substring(0, refineWord.length - 1)) &&
          (refineWord.lastIndexOf('d') == (refineWord.length - 1))) {
        if (kDebugMode) {
          print(
              "Remove d in verb in the past Ex: play (chơi) → played (đã chơi)");
        }

        // Add found word to history file
        await HistoryManager.saveWordToHistory(
            refineWord.upperCaseFirstLetter());
        return wordList[i];
      }
    }
    for (int i = 0; i < wordList.length; i++) {
      String word = wordList[i].word;
      // Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)
      if (word.startsWith(refineWord.substring(0, refineWord.length - 2)) &&
          (refineWord.lastIndexOf('ed') == (refineWord.length - 2)) &&
          (word.substring(0, word.indexOf(' ')) ==
              refineWord.substring(0, refineWord.length - 2))) {
        if (kDebugMode) {
          print(
              "Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)");
        }

        // Add found word to history file
        await HistoryManager.saveWordToHistory(
            refineWord.upperCaseFirstLetter());
        return wordList[i];
      }
    }
    return Word.empty();
  }

  Future<Word> _getDefinitionForAndroid(String word) async {
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
    final dbHelper = DictionaryDatabaseAndroid.instance;
    var result = await dbHelper.queryDictionary(refinedWord);
    if (result.isNotEmpty) {
      final definition = result[0]['definition'];
      final pronounce = result[0]['pronounce'];

      // Handle the definition and pronounce data as needed
      if (kDebugMode) {
        print('Definition: $definition');
      }
      if (kDebugMode) {
        print('Pronunciation: $pronounce');
      }

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
