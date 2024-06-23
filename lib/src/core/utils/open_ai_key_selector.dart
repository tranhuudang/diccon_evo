import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/encrypt_api.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../core.dart';

class OpenAIKeySelector {
  OpenAIKeySelector._();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final OpenAIKeySelector _instance = OpenAIKeySelector._();

  static Future<int> init() async {
    return await _instance.setPrimaryKey();
  }

  Future<int> setPrimaryKey() async {
    // Primary local key
    bool isPrimaryKeyValid = await checkApiKeyValidity(Env.openaiApiKey);
    if (isPrimaryKeyValid) {
      DebugLog.info('Using Primary API Key');
      ApiKeys.openAiKey = Env.openaiApiKey;
      return 1;
    }

    DebugLog.info('Getting key from cloud...');
    // Primary Cloud Key
    String rawPrimaryKeyFromCloud =
        await _getOpenApiKeyFromFirestore(from: 'primary');
    String primaryKeyFromCloud =
        EncryptApi.decode(encodedContent: rawPrimaryKeyFromCloud);
    bool primaryKeyFromCloudValid =
        await checkApiKeyValidity(primaryKeyFromCloud);
    if (primaryKeyFromCloudValid) {
      DebugLog.info('Using primary API Key from Cloud');
      ApiKeys.openAiKey = primaryKeyFromCloud;
      return 3;
    }
    // Backup Cloud Key
    String rawBackupKeyFromCloud =
        await _getOpenApiKeyFromFirestore(from: 'primary');
    String backupKeyFromCloud =
        EncryptApi.decode(encodedContent: rawBackupKeyFromCloud);
    bool backupKeyFromCloudValid =
        await checkApiKeyValidity(backupKeyFromCloud);
    if (backupKeyFromCloudValid) {
      DebugLog.info('Using backup API Key from Cloud');
      ApiKeys.openAiKey = backupKeyFromCloud;
      return 4;
    }

    ApiKeys.openAiKey = Env.openaiApiKey;
    return 0;
  }

  Future<String> _getOpenApiKeyFromFirestore({required String from}) async {
    String value = '';
    try {
      DocumentSnapshot documentSnapshot =
          await _firestore.collection(FirebaseConstant.firestore.api).doc(FirebaseConstant.firestore.openApi).get();
      if (documentSnapshot.exists) {
        value = documentSnapshot[from].toString();
      }
    } catch (e) {
      value = "Error retrieving document: $e";
    }
    return value;
  }

  Future<bool> checkApiKeyValidity(String key) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $key',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {'role': 'system', 'content': 'You are a helpful assistant.'},
            {'role': 'user', 'content': 'Hello, world!'}
          ],
          'max_tokens': 5,
        }),
      );

      if (response.statusCode == 200) {
        DebugLog.info('OpenAI API key is valid.');
        return true;
      } else if (response.statusCode == 401) {
        DebugLog.info(
            'Primary OpenAI API key is not valid, switch to use backup key.');
        return false;
      } else if (response.statusCode == 429) {
        DebugLog.info('OpenAI API rate limit exceeded.');
        return false;
      } else {
        DebugLog.error(
            'Failed to check API key validity, unexpected status code: ${response.statusCode}');

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
