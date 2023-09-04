
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/properties.dart';
import '../../../helpers/article_handler.dart';
import '../../../models/article.dart';


class ArticleHistoryListCubit extends Cubit<List<Article>> {
  ArticleHistoryListCubit() : super([]);

  List<Article> articles = [];

  void loadArticleHistory() async {
    articles = await ArticleHandler.readArticleHistory();
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
    ArticleHandler.deleteFile(Properties.articleHistoryFileName);
    articles = List.empty();
    emit(articles);
  }

  void sortElementary() {
    var elementaryOnly =
        articles.where((element) => element.level == Level.elementary).toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = articles
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly =
        articles.where((element) => element.level == Level.advanced).toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = articles;
    emit(all);
  }
}
