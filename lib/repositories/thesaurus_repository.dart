import 'dart:convert';
import 'package:flutter/services.dart';

import '../properties.dart';

class ThesaurusRepository {
  Future<Map<String, List<String>>> loadSynonymsData() async {
    String jsonString = await rootBundle.loadString(Properties.enSynonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  Future<Map<String, List<String>>> loadAntonymsData() async {
    String jsonString = await rootBundle.loadString(Properties.enAntonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }
}
