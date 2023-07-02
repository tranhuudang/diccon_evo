import '../global.dart';
import '../interfaces/thesaurus.dart';

class ThesaurusService {
  final Thesaurus thesaurus;
  ThesaurusService(this.thesaurus);

  Future<void> loadThesaurus() async {
    Global.synonymsData = await thesaurus.loadSynonymsData();
    Global.antonymsData = await thesaurus.loadAntonymsData();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getSynonyms(String word) {
    List<String> synonyms = Global.synonymsData[word] ?? [];
    return synonyms.take(Global.numberOfSynonyms).toList();
  }

  /// Return a list of String synonyms for provided word and return [] if nothing found
  List<String> getAntonyms(String word) {
    List<String> synonyms = Global.antonymsData[word] ?? [];
    return synonyms.take(Global.numberOfAntonyms).toList();
  }
}
