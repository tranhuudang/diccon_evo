import '../models/word.dart';

 abstract class Data{
   Future<List<Word>> getWordList();
   Future<List<String>> getSuggestionWordList();
}