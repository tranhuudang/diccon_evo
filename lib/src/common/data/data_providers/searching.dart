import 'package:flutter/foundation.dart';
import '../models/word.dart';
import 'dictionary_database.dart';
import 'history_manager.dart';
import 'package:diccon_evo/src/common/common.dart';

class Searching {
  // static Future<Word> getDefinition(String searchWord) async  {
  //   var refineWord = searchWord.removeSpecialCharacters().trim().toLowerCase();
  //
  //   if (kDebugMode) {
  //     print("refined word:[$refineWord]");
  //   }
  //   for (int i = 0; i < Properties.wordList.length; i++) {
  //     String word = Properties.wordList[i].word;
  //
  //     if (word == refineWord) {
  //       if (kDebugMode) {
  //         print("Start to get the value that completely match with user input");
  //       }
  //
  //       // Add found word to history file
  //       await HistoryManager.saveWordToHistory(refineWord.upperCaseFirstLetter());
  //       return Properties.wordList[i];
  //     } else
  //
  //     // Start to get the value that completely match with user input
  //     if (word.startsWith("$refineWord${PropertiesConstants.blankSpace}")) {
  //       if (kDebugMode) {
  //         print("Start to get the value that completely match with user input");
  //       }
  //
  //       // Add found word to history file
  //       await HistoryManager.saveWordToHistory(refineWord.upperCaseFirstLetter());
  //       return Properties.wordList[i];
  //     }
  //   }
  //   for (int i = 0; i < Properties.wordList.length; i++) {
  //     String word = Properties.wordList[i].word;
  //
  //     // Remove s in plural word to get the singular word
  //     if (word.startsWith(refineWord.substring(0, refineWord.length - 1)) &&
  //         (refineWord.lastIndexOf('s') == (refineWord.length - 1))) {
  //       if (kDebugMode) {
  //         print("Remove s in plural word to get the singular word");
  //       }
  //
  //       // Add found word to history file
  //       await HistoryManager.saveWordToHistory(refineWord.upperCaseFirstLetter());
  //       return Properties.wordList[i];
  //     } else
  //     // Remove d in verb in the past Ex: play (chơi) → played (đã chơi)
  //     if (word.startsWith(refineWord.substring(0, refineWord.length - 1)) &&
  //         (refineWord.lastIndexOf('d') == (refineWord.length - 1))) {
  //       if (kDebugMode) {
  //         print(
  //             "Remove d in verb in the past Ex: play (chơi) → played (đã chơi)");
  //       }
  //
  //       // Add found word to history file
  //       await HistoryManager.saveWordToHistory(refineWord.upperCaseFirstLetter());
  //       return Properties.wordList[i];
  //     }
  //   }
  //   for (int i = 0; i < Properties.wordList.length; i++) {
  //     String word = Properties.wordList[i].word;
  //     // Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)
  //     if (word.startsWith(refineWord.substring(0, refineWord.length - 2)) &&
  //         (refineWord.lastIndexOf('ed') == (refineWord.length - 2)) &&
  //         (word.substring(0, word.indexOf(' ')) ==
  //             refineWord.substring(0, refineWord.length - 2))) {
  //       if (kDebugMode) {
  //         print(
  //             "Remove ed in verb in the past Ex: dance (nhảy múa) → danced (đã nhảy múa)");
  //       }
  //
  //       // Add found word to history file
  //       await HistoryManager.saveWordToHistory(refineWord.upperCaseFirstLetter());
  //       return Properties.wordList[i];
  //     }
  //   }
  //   return Word.empty();
  // }

  static Future<Word> getDefinition(String word) async {
    final dbHelper = DatabaseHelper.instance;
    final result = await dbHelper.queryDictionary(word);

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
      return Word(word: word, pronunciation: pronounce, definition: definition);
    } else {
      if (kDebugMode) {
        print('Word not found in the dictionary.');
      }
      return Word.empty();
    }
  }
}
