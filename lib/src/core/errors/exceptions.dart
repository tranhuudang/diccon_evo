class AudioHandlerException implements Exception {
  final String message;
  AudioHandlerException(this.message);
}

class SpeechToTextApiClientException implements Exception {
  final String message;
  SpeechToTextApiClientException(this.message);
}