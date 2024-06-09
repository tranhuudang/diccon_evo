import 'dart:convert';

import 'package:diccon_evo/src/core/configs/configs.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class OpenAIKeySelector {
  OpenAIKeySelector._();

  static final OpenAIKeySelector _instance = OpenAIKeySelector._();

  static Future<void> init() async {
    await _instance.setPrimaryKey();
  }

  Future<void> setPrimaryKey() async {
    bool isKeyValid = await checkApiKeyValidity();
    if (isKeyValid) {
      print('Using Primary API Key');
      ApiKeys.openAiKey = Env.openaiApiKey;
    } else {
      print('Using backup API Key');
      ApiKeys.openAiKey = Env.openaiApiKeyBackup;
    }
  }

  Future<bool> checkApiKeyValidity() async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer ${Env.openaiApiKey}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'prompt': 'Hello, world!',
          'max_tokens': 5,
        }),
      );

      if (kDebugMode) {
        print('Response status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        response.headers.forEach((key, value) {
          print('$key: $value');
        });
      }

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Primary OpenAI API key is valid.');
          print('Rate Limit Remaining: ${response.headers['x-ratelimit-remaining']}');
        }
        return true;
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print('Primary OpenAI API key is not valid, switch to use backup key.');
        }
        return false;
      } else if (response.statusCode == 429) {
        if (kDebugMode) {
          print('Rate limit exceeded. Please try again later.');
          print('Rate Limit Reset: ${response.headers['x-ratelimit-reset']}');
        }
        return false;
      } else {
        if (kDebugMode) {
          print('Failed to check API key validity, unexpected status code: ${response.statusCode}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error checking API key validity: $e');
      }
      return false;
    }
  }
}
