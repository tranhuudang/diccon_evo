import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../core/core.dart';

class TextToSpeechApiClient {
  http.Client? _client; // Define a client instance

  /// Converts text to speech using an API endpoint and saves the result to a file.
  ///
  /// Parameters:
  /// - fromText: The text to be converted into speech.
  /// - toFilePath: The file path where the converted speech will be saved.
  ///
  /// Returns:
  /// void - The function doesn't return any data but saves the speech audio to a file.
  Future<String> convertTextToSpeech({
    required String fromText,
    required String toFilePath,
  }) async {
    _client = http.Client(); // Initialize the client
    final uri = Uri.parse(ApiEndpoints.speech);
    final headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${Env.openaiApiKey}',
      HttpHeaders.contentTypeHeader: 'application/json',
    };
    final body = jsonEncode({
      'model': SpeechModels.tts1,
      'input': fromText,
      'voice': SupportedVoices.onyx.name,
    });

    try {
      final response = await _client!.post(uri, headers: headers, body: body);

      if (kDebugMode) {
        print(response.statusCode);
      }

      // write data to local storage
      final file = File(toFilePath);
      await file.writeAsBytes(response.bodyBytes);

      if (kDebugMode) {
        print('file is written to local storage');
      }
      return toFilePath;
    } catch (e) {
      // Handle any errors or cancellations here
      print('Error occurred: $e');
      return '';
    } finally {
      _client?.close(); // Close the client after the request is done
    }
  }

  void cancelRequest() {
    _client?.close(); // Call this function to cancel the ongoing request
  }
}
