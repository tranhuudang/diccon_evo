import 'package:diccon_evo/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../properties.dart';
import '../helpers/file_handler.dart';

class ArticleHistoryListCubit extends Cubit<List<Article>> {
  ArticleHistoryListCubit() : super([]);

  List<Article> articles = [];

  void loadArticleHistory() async {
    articles = await FileHandler.readArticleHistory();
    emit(articles);
  }

  void sortAlphabet() {
    var sorted = articles;
    sorted.sort((a, b) => a.title.compareTo(b.title));
    emit(sorted);
  }

  void sortReverse() {
    var sorted = articles.reversed.toList();
    emit(sorted);
  }

  void clearHistory() {
    FileHandler.deleteFile(Properties.ARTICLE_HISTORY_FILENAME);
    articles = List.empty();
    emit(articles);
  }

  void sortElementary() {
    var elementaryOnly = articles
        .where((element) => element.level == Level.elementary)
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = articles
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = articles
        .where((element) => element.level == Level.advanced)
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = articles;
    emit(all);
  }
}