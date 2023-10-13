import 'dart:convert';
import 'package:flutter/services.dart';
import '../../config/properties.dart';
import '../../config/properties_constants.dart';

class ThesaurusRepository {
  Future<void> loadThesaurus() async {
    Properties.synonymsData = await loadSynonymsData();
    Properties.antonymsData = await loadAntonymsData();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getSynonyms(String word) {
    List<String> synonyms = Properties.synonymsData[word] ?? [];
    return synonyms.take(Properties.defaultSetting.numberOfSynonyms).toList();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getAntonyms(String word) {
    List<String> synonyms = Properties.antonymsData[word] ?? [];
    return synonyms.take(Properties.defaultSetting.numberOfAntonyms).toList();
  }

  Future<Map<String, List<String>>> loadSynonymsData() async {
    String jsonString = await rootBundle.loadString(PropertiesConstants.enSynonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  Future<Map<String, List<String>>> loadAntonymsData() async {
    String jsonString = await rootBundle.loadString(PropertiesConstants.enAntonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }
}
