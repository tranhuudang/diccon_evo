abstract class Thesaurus {
  Future<Map<String,List<String>>> loadAntonymsData();
  Future<Map<String,List<String>>> loadSynonymsData();
}