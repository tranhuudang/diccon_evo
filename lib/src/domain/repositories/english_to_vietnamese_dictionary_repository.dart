import '../domain.dart';

abstract class EnglishToVietnameseDictionaryRepository {
  Future<List<String>> getSynonyms(String word);
  Future<List<String>> getAntonyms(String word);
}