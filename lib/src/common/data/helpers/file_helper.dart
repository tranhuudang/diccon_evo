import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class FileHelper{
  static Future<dynamic> getJsonFromUrl(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // If the request is successful, parse the JSON
      return json.decode(response.body);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to fetch JSON from URL');
    }
  }
  /// Read default stories data
  static Future<String> getAssetFile(String filePath) async {
    return await rootBundle.loadString(filePath);
  }
}