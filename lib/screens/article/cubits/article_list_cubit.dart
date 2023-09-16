import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:async/async.dart';
import '../../../config/properties.dart';
import '../../../models/article.dart';
import '../../../repositories/article_repository.dart';

class ArticleListCubit extends Cubit<List<Article>> {
  ArticleListCubit() : super([]);

  CancelableOperation? _cancelableOperation;

  void cancelLoading() async {
    await _cancelableOperation?.cancel();
    emit(Properties.defaultArticleList);
  }

  void getAllArticle() async {
    _cancelableOperation = CancelableOperation.fromFuture(
        // The process will automaticly cancel after 5 seconds if it not complete
        _loadAll().timeout(
          const Duration(seconds: 5),
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
    var elementaryOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.elementary)
        .toList();
    emit(elementaryOnly);
  }

  void sortIntermediate() {
    var intermediateOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.intermediate)
        .toList();
    emit(intermediateOnly);
  }

  void sortAdvanced() {
    var advancedOnly = Properties.defaultArticleList
        .where((element) => element.level == Level.advanced)
        .toList();
    emit(advancedOnly);
  }

  void getAll() {
    var all = Properties.defaultArticleList;
    emit(all);
  }

  Future<void> _loadAll() async {
    Properties.defaultArticleList = await ArticleRepository.getDefaultStories();
    var onlineStories = await ArticleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        Properties.defaultArticleList.add(story);
      }
    }
    Properties.defaultArticleList.shuffle();
    emit(Properties.defaultArticleList);
  }
}
