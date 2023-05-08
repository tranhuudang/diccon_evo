import '../global.dart';
import '../models/word.dart';

class Searching {
  static Word? getDefinition(String searchWord) {
    for (int i = 0; i < Global.wordList.length; i++) {
      String word = Global.wordList[i].word;
      if (word.startsWith("$searchWord${Global.BLANK_SPACE}")) {
        return Global.wordList[i];
      }
      else if(word.startsWith(searchWord))
      {
        return Global.wordList[i];
      }
    }
    return null;
  }
}
