import 'dart:convert';
import 'package:flutter/services.dart';

import '../global.dart';

class ThesaurusDictionary {
  Future<void> loadSynonymsData() async {
    String jsonString =
        await rootBundle.loadString(Global.EN_SYNONYMS_PATH);
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

  Future<void> loadAntonymsData() async {
    String jsonString =
    await rootBundle.loadString(Global.EN_ANTONYMS_PATH);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Global.antonymsData = jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getAntonyms(String word) {
    List<String> synonyms = Global.antonymsData[word] ?? [];
    return synonyms.take(Global.numberOfAntonyms).toList();
  }
}
