import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

class SuggestionDatabase {
  SuggestionDatabase._();
  static final SuggestionDatabase instance = SuggestionDatabase._();
  List<String> _database = [];
  Future<List<String>> get database async {
    if (_database.isNotEmpty) return _database;
    _database = await initDb();
    return _database;
  }

  Future<List<String>> initDb() async {
    try {
      var content =
          await rootBundle.loadString(LocalDirectory.suggestionListPath);
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
