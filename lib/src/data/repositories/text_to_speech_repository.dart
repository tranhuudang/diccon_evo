import 'package:diccon_evo/src/data/data_providers/text_to_speech_client.dart';
import 'package:diccon_evo/src/core/enum/sex.dart';

class TextToSpeechRepository {
  final TextToSpeechApiClient textToSpeechApiClient = TextToSpeechApiClient();

  /// Converts text to speech and saves it to a file.
  ///
  /// Parameters:
  /// - fromText: The text to be converted into speech.
  /// - toFilePath: The file path where the converted speech will be saved.
  Future<String> convertTextToSpeech({
    required String fromText,
    required String toFilePath,
     Sex withSex = Sex.men,
  }) {
    return textToSpeechApiClient.convertTextToSpeech(
        fromText: fromText, toFilePath: toFilePath, withSex: withSex);
  }

  void dispose(){
    textToSpeechApiClient.cancelRequest();
  }
}
