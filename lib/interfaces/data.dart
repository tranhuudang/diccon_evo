import '../models/article.dart';
import '../models/word.dart';

 abstract class Data{
   Future<List<Word>> getWordList();
   Future<List<Article>> getOnlineStoryList();
   Future<List<Article>> getDefaultStories();
}