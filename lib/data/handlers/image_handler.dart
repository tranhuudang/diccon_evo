import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ImageHandler {
  Future<String> getImageFromPixabay(String word) async {
    try {
      final response = await http.get(Uri.parse(
          'https://pixabay.com/api/?key=25829393-af32bf17ec8386b5941fb5f8f&q=$word&image_type=photo'));
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON
        var jsonData = json.decode(response.body);
        try {
          var imageUrl = jsonData["hits"][0]["webformatURL"].toString();
          return imageUrl;
        } catch (e) {
          if (kDebugMode) {
            print("[Image Handler] : $e");
          }
          return '';
        }
      } else {
        // If the server returns an error response, throw an exception
        if (kDebugMode) {
          print("[Image Handler] : Pixabay response with code ${response.statusCode}");
        }
        return '';
      }
    } catch (e)
    {
      if (kDebugMode) {
        print("[Image Handler] : $e");
      }
      return '';
    }
  }
}
