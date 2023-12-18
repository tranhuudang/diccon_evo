class ApiEndpoints{
  /// Pixabay API url for image
  static const String pixabayURL = 'https://pixabay.com/api/';
  /// OpenAI base url
  static const String baseUrl = 'https://api.openai.com';
  /// Endpoint for transcribes audio into the input language.
  static const String transcriptions = '$baseUrl/v1/audio/transcriptions';
  /// Endpoint for generates audio from the input text.
  static const String speech = '$baseUrl/v1/audio/speech';
  /// Endpoint for Represents a chat completion response returned by model, based on the provided input.
  static const String chatCompletion = '$baseUrl/v1/chat/completions';
}