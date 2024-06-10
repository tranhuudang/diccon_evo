import 'package:diccon_evo/src/core/core.dart';
import '../../domain/domain.dart';
import '../data.dart';

class EnglishToVietnameseDictionaryRepositoryImpl implements EnglishToVietnameseDictionaryRepository {
  @override
  Future<List<String>> getSynonyms(String word) async {
    var thesaurus = ThesaurusDatabase.instance;
    var thesaurusDb = await thesaurus.sysnonymsDatabase;
    List<String> synonyms = thesaurusDb[word] ?? [];
    return synonyms.take(Properties.instance.settings.numberOfSynonyms).toList();
  }

  @override
  Future<List<String>> getAntonyms(String word) async {
    var thesaurus = ThesaurusDatabase.instance;
    var thesaurusDb = await thesaurus.antonymsDatabase;
    List<String> synonyms = thesaurusDb[word] ?? [];
    return synonyms.take(Properties.instance.settings.numberOfAntonyms).toList();
  }
}
