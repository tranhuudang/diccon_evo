import '../properties.dart';
import '../models/word.dart';

class Searching {


  static Word? getDefinition(String searchWord) {
    for (int i = 0; i < Properties.wordList.length; i++) {
      String word = Properties.wordList[i].word;
      if (word.startsWith("$searchWord${Properties.blankSpace}")) {
        return Properties.wordList[i];
      }
      else if(word.startsWith(searchWord))
      {
        return Properties.wordList[i];
      }
    }
    return null;
  }
}
