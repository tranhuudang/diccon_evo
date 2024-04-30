import 'dart:typed_data';


import '../data_providers/speech_to_text_client.dart';

class SpeechToTextRepository {
  final SpeechToTextApiClient speechToTextApiClient = SpeechToTextApiClient();

  /// Converts speech to text.
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
    String model = 'whisper-1',
  }) {
    return speechToTextApiClient.convertSpeechToText(
        fileName: fileName, audio: audio);
  }
}
