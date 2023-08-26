import 'package:diccon_evo/repositories/thesaurus_repository.dart';

import '../config/properties.dart';

class ThesaurusService {
  final ThesaurusRepository thesaurusRepository;
  ThesaurusService(this.thesaurusRepository);

  Future<void> loadThesaurus() async {
    Properties.synonymsData = await thesaurusRepository.loadSynonymsData();
    Properties.antonymsData = await thesaurusRepository.loadAntonymsData();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getSynonyms(String word) {
    List<String> synonyms = Properties.synonymsData[word] ?? [];
    return synonyms.take(Properties.defaultNumberOfSynonyms).toList();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getAntonyms(String word) {
    List<String> synonyms = Properties.antonymsData[word] ?? [];
    return synonyms.take(Properties.defaultNumberOfAntonyms).toList();
  }
}
