import 'dart:convert';
import 'package:flutter/services.dart';

import '../global.dart';

class SynonymsDictionary {
  Future<void> loadSynonymsData() async {
    String jsonString =
        await rootBundle.loadString('assets/synonyms/english_synonyms.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Global.synonymsData = jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getSynonyms(String word) {
    List<String> synonyms = Global.synonymsData[word] ?? [];
    return synonyms.take(Global.numberOfSynonyms).toList();
  }
}
