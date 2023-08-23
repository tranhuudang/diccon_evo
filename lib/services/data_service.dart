import 'package:diccon_evo/interfaces/data.dart';
import '../models/word.dart';

class DataService {
  final Data data;

  DataService(this.data);
  Future<List<Word>> getWordList() async {
    return await data.getWordList();
  }

  Future<List<String>> getSuggestionWordList() async {
    return await data.getSuggestionWordList();
  }
}
