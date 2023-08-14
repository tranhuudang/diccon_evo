import '../properties.dart';
import '../interfaces/thesaurus.dart';

class ThesaurusService {
  final Thesaurus thesaurus;
  ThesaurusService(this.thesaurus);

  Future<void> loadThesaurus() async {
    Properties.synonymsData = await thesaurus.loadSynonymsData();
    Properties.antonymsData = await thesaurus.loadAntonymsData();
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
