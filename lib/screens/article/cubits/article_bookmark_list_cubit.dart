
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/article.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/article_repository.dart';

class ArticleBookmarkListCubit extends Cubit<List<Article>> {
  ArticleBookmarkListCubit() : super([]);

  final articleRepository = ArticleRepository();
  List<Article> articles = [];

  void addBookmark(Article article){
    articleRepository.saveReadArticleToBookmark(article);
    if (!articles.contains(article)) {
      articles.add(article);
    }
    emit(articles);
  }

  void loadArticleBookmark() async {
    articles = await articleRepository.readArticleBookmark();
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
    articleRepository.deleteAllArticleBookmark();
    articles = List.empty();
    emit(articles);
  }

  void sortElementary() {
    var elementaryOnly =
        articles.where((element) => element.level == Level.elementary.toLevelNameString()).toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = articles
        .where((element) => element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly =
        articles.where((element) => element.level == Level.advanced.toLevelNameString()).toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = articles;
    emit(all);
  }
}
