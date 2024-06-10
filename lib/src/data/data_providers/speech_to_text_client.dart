import 'dart:convert';
import 'dart:io';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/enum/transcription_models.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


// Handles API calls for speech-to-text conversion
class SpeechToTextApiClient {
  http.Client? _client; // Define a client instance

  /// Converts speech to text using an API endpoint.
  ///
  /// Parameters:
  /// - fileName: The name or identifier of the audio file.
  /// - audio: The audio data in [ByteData] format to be converted.
  /// - model: The model used for speech-to-text conversion (default: 'whisper-1').
  ///
  /// Returns:
  /// A [Map] containing the result of speech-to-text conversion.
  Future<Map<String, dynamic>> convertSpeechToText({
    required String fileName,
    required ByteData audio,
    String model = TranscriptionModels.whisper1,
  }) async {
    _client = http.Client(); // Initialize the client

    try {
      final uri = Uri.parse(ApiEndpoints.transcriptions);
      var request = http.MultipartRequest('POST', uri);
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${ApiKeys.openAiKey}';

      var multipartFile = http.MultipartFile.fromBytes(
        'file',
        audio.buffer.asInt8List(),
        filename: fileName,
        contentType: MediaType('audio', 'm4a'),
      );

      request.fields['model'] = model;
      request.fields['language'] = 'en';
      request.files.add(multipartFile);

      final streamedResponse = await _client!.send(request);
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {
        if (kDebugMode) {
          print(GptErrorData.getError(response.statusCode));
        }
        throw SpeechToTextApiClientException(
          GptErrorData.getError(response.statusCode).cause,
        );
      }
    } catch (e) {
      throw SpeechToTextApiClientException(
        '${ExceptionStrings.errorConvertSpeechToText}$e',
      );
    } finally {
      _client
          ?.close(); // Close the client after the request is done or if an error occurs
    }
  }

  void cancelRequest() {
    _client?.close(); // Call this function to cancel the ongoing request
  }
}
