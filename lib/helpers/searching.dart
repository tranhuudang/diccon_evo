import 'package:diccon_evo/extensions/string.dart';

import '../config/properties.dart';
import '../models/word.dart';

class Searching {
  static Word? getDefinition(String searchWord) {
    var refineWord = searchWord.removeSpecialCharacters().trim();
    print("refined word:$refineWord");
    for (int i = 0; i < Properties.wordList.length; i++) {
      String word = Properties.wordList[i].word;
      if (word.startsWith("$refineWord${Properties.blankSpace}")) {
        print("1");

        return Properties.wordList[i];
      }
      if (word.startsWith(refineWord.substring(0, refineWord.length - 1)) && (refineWord.lastIndexOf('s') == (refineWord.length - 1))) {
        print("2");
        return Properties.wordList[i];
      }
      if (word.startsWith(refineWord)) {
        print("3");

        return Properties.wordList[i];
      }

    }
    return null;
  }
}