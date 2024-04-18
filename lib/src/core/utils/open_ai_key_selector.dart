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
      ApiKeys.openAiKey = Env.openaiApiKey;
    } else {
      ApiKeys.openAiKey = Env.openaiApiKeyBackup;
    }
  }

  Future<bool> checkApiKeyValidity() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.openai.com/v1/models'),
        headers: {
          'Authorization': 'Bearer ${Env.openaiApiKey}',
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Primary OpenAI API key is valid.');
        }
        return true;
      } else if (response.statusCode == 401) {
        if (kDebugMode) {
          print('Primary OpenAI API key is not valid, switch to use backup key.');
        }
        return false;
      } else {
        if (kDebugMode) {
          print('Failed to check API key validity, switch to use backup key.');
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
