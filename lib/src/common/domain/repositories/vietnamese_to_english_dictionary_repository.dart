import 'package:diccon_evo/src/common/common.dart';

abstract class VietnameseToEnglishDictionaryRepository {
  Future<Word> getDefinition(String word);
  // Future<List<String>> getSynonyms(String word);
  // Future<List<String>> getAntonyms(String word);
}