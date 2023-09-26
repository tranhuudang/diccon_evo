import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';
import '../../../config/properties.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/models/article.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/article_repository.dart';

class ArticleListCubit extends Cubit<List<Article>> {
  ArticleListCubit() : super([]);

  final articleRepository = ArticleRepository();
  List<Article> defaultArticleList = [];
  CancelableOperation? _cancelableOperation;

  void cancelLoading() async {
    await _cancelableOperation?.cancel();
    emit(defaultArticleList);
  }

  void getAllArticle() async {
    _cancelableOperation = CancelableOperation.fromFuture(
        // The process will automaticly cancel after 10 seconds if it not complete
        _loadAll().timeout(
          const Duration(seconds: 10),
          // Calling cancel
          onTimeout: () {
            cancelLoading();
          },
        ), onCancel: () {
      if (kDebugMode) {
        print("Loading article is canceled");
      }
    });
  }

  void reGetAllArticle() async {
    _cancelableOperation = CancelableOperation.fromFuture(
      // The process will automaticly cancel after 10 seconds if it not complete
        _reLoadAll().timeout(
          const Duration(seconds: 10),
          // Calling cancel
          onTimeout: () {
            cancelLoading();
          },
        ), onCancel: () {
      if (kDebugMode) {
        print("Loading article is canceled");
      }
    });
  }


  void sortElementary() {
    var elementaryOnly = defaultArticleList
        .where((element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = defaultArticleList
        .where((element) => element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = defaultArticleList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = defaultArticleList;
    emit(all);
  }

  Future<void> _loadAll() async {
    defaultArticleList = await articleRepository.getDefaultStories();
    var onlineStories = await articleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultArticleList.add(story);
      }
    }
    emit(defaultArticleList);
  }

  Future<void> _reLoadAll() async {
    /// Remove downloaded extend-story.json
    await FileHandler(Properties.extendStoryFileName).delete();
    defaultArticleList = await articleRepository.getDefaultStories();
    var onlineStories = await articleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultArticleList.add(story);
      }
    }
    emit(defaultArticleList);
  }
}
