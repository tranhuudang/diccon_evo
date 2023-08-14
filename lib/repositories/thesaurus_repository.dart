import 'dart:convert';
import 'package:flutter/services.dart';

import '../properties.dart';
import '../interfaces/thesaurus.dart';

class ThesaurusRepository implements Thesaurus {

  @override
  Future<Map<String,List<String>>> loadSynonymsData() async {
    String jsonString = await rootBundle.loadString(Properties.EN_SYNONYMS_PATH);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  @override
  Future<Map<String,List<String>>> loadAntonymsData() async {
    String jsonString = await rootBundle.loadString(Properties.EN_ANTONYMS_PATH);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }


}
