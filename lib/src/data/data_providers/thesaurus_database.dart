import 'dart:convert';
import 'package:flutter/services.dart';

import '../../core/constants/constants.dart';

class ThesaurusDatabase {
  ThesaurusDatabase._();

  static final ThesaurusDatabase instance = ThesaurusDatabase._();
  Map<String, List<String>> _synonymsDatabase = {};
  Map<String, List<String>> _antonymsDatabase = {};

  Future<Map<String, List<String>>> get sysnonymsDatabase async {
    if (_synonymsDatabase.isNotEmpty) return _synonymsDatabase;
    _synonymsDatabase = await loadSynonymsData();
    return _synonymsDatabase;
  }

  Future<Map<String, List<String>>> get antonymsDatabase async {
    if (_antonymsDatabase.isNotEmpty) return _antonymsDatabase;
    _antonymsDatabase = await loadAntonymsData();
    return _antonymsDatabase;
  }

  Future<Map<String, List<String>>> loadSynonymsData() async {
    String jsonString =
        await rootBundle.loadString(LocalDirectory.enSynonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }

  Future<Map<String, List<String>>> loadAntonymsData() async {
    String jsonString =
        await rootBundle.loadString(LocalDirectory.enAntonymsPath);
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    return jsonData.map((key, value) {
      return MapEntry<String, List<String>>(key, List<String>.from(value));
    });
  }
}
