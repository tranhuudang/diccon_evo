
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/properties.dart';
import '../../../helpers/article_handler.dart';
import '../../../models/article.dart';


class ArticleBookmarkListCubit extends Cubit<List<Article>> {
  ArticleBookmarkListCubit() : super([]);

  List<Article> articles = [];

  void addBookmark(Article article){
    ArticleHandler.saveReadArticleToBookmark(article);
    articles.add(article);
    emit(articles);
  }

  void loadArticleBookmark() async {
    articles = await ArticleHandler.readArticleBookmark();
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

  void clearBookmark() {
    ArticleHandler.deleteFile(Properties.articleBookmarkFileName);
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
