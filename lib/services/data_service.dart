import 'package:diccon_evo/repositories/data_repository.dart';
import '../models/word.dart';

class DataService {
  final DataRepository dataRepository;

  DataService(this.dataRepository);
  Future<List<Word>> getWordList() async {
    return await dataRepository.getWordList();
  }

  Future<List<String>> getSuggestionWordList() async {
    return await dataRepository.getSuggestionWordList();
  }
}
