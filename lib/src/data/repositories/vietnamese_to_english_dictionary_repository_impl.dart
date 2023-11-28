import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/foundation.dart';
import '../../domain/domain.dart';
import '../data.dart';

class VietnameseToEnglishDictionaryRepositoryImpl implements VietnameseToEnglishDictionaryRepository {

  @override
  Future<Word> getDefinition(String word) async {
      return await _getDefinitionForAndroidAndWindows(word);
  }
  Future<Word> _getDefinitionForAndroidAndWindows(String word) async {
    var result = await _getResultFromSQLiteDatabase(word);
    if (result != Word.empty()) return result;
    if (kDebugMode) {
      print('Word not found in the dictionary.');
    }
    return Word.empty();
  }

  Future<Word> _getResultFromSQLiteDatabase(String refinedWord) async {
    final dbHelper = VietnameseToEnglishDictionaryDatabase.instance;
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
}
