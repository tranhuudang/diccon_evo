abstract class DialogueRepository{
  /// Return filePath of audio file
  Future<String> getAudio(String sentence);
}