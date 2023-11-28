import '../domain.dart';

abstract class VietnameseToEnglishDictionaryRepository {
  Future<Word> getDefinition(String word);
  // Future<List<String>> getSynonyms(String word);
  // Future<List<String>> getAntonyms(String word);
}