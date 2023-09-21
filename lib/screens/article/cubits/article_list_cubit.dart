import 'package:diccon_evo/helpers/file_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';
import '../../../config/properties.dart';
import '../../../models/article.dart';
import '../../../models/level.dart';
import '../../../repositories/article_repository.dart';

class ArticleListCubit extends Cubit<List<Article>> {
  ArticleListCubit() : super([]);

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
    defaultArticleList = await ArticleRepository.getDefaultStories();
    var onlineStories = await ArticleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultArticleList.add(story);
      }
    }
    defaultArticleList.shuffle();
    emit(defaultArticleList);
  }

  Future<void> _reLoadAll() async {
    /// Remove downloaded extend-story.json
    await FileHandler(Properties.extendStoryFileName).deleteFile();
    defaultArticleList = await ArticleRepository.getDefaultStories();
    var onlineStories = await ArticleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultArticleList.add(story);
      }
    }
    defaultArticleList.shuffle();
    emit(defaultArticleList);
  }
}
