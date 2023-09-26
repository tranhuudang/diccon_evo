import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/properties.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/models/article.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/article_repository.dart';

/// Events
abstract class ArticleListEvent {}

class ArticleListInitial extends ArticleListEvent {}

class ArticleListReload extends ArticleListEvent {}

class ArticleListCancelLoad extends ArticleListEvent {}

class ArticleListSortElementary extends ArticleListEvent {}

class ArticleListSortIntermediate extends ArticleListEvent {}

class ArticleListSortAdvanced extends ArticleListEvent {}

class ArticleListSortAll extends ArticleListEvent {}

/// States
abstract class ArticleListState {}

class ArticleListUninitialized extends ArticleListState {
  List<Article> defaultArticleList = [];
  ArticleListUninitialized(this.defaultArticleList);
}

class ArticleListInitializedState extends ArticleListState {
  List<Article> articleList = [];
  ArticleListInitializedState({required this.articleList});
}

/// Bloc
class ArticleListBloc extends Bloc<ArticleListEvent, ArticleListState> {
  ArticleListBloc() : super(ArticleListUninitialized([])) {
    on<ArticleListInitial>(_getAllArticle);
    on<ArticleListReload>(_reGetAllArticle);
    on<ArticleListCancelLoad>(_cancelLoading);
    on<ArticleListSortElementary>(_sortElementary);
    on<ArticleListSortIntermediate>(_sortIntermediate);
    on<ArticleListSortAdvanced>(_sortAdvanced);
    on<ArticleListSortAll>(_sortAll);
  }

  final articleRepository = ArticleRepository();
  List<Article> defaultArticleList = [];

  FutureOr<void> _getAllArticle(
      ArticleListInitial event, Emitter<ArticleListState> emit) async {
    await _loadAll().timeout(const Duration(seconds: 10), onTimeout: (){
      if (kDebugMode) {
        print("Load all article reach timeout 10 seconds limit.");
      }
    });
    emit(ArticleListInitializedState(articleList: defaultArticleList));
  }

  FutureOr<void> _reGetAllArticle(
      ArticleListReload event, Emitter<ArticleListState> emit) async {
    await _reLoadAll().timeout(const Duration(seconds: 10), onTimeout: (){
      if (kDebugMode) {
        print("Reload all article reach timeout 10 seconds limit.");
      }
    });
    emit(ArticleListInitializedState(articleList: defaultArticleList));
  }

  FutureOr<void> _cancelLoading(
      ArticleListCancelLoad event, Emitter<ArticleListState> emit) async {
    //await _cancelableOperation?.cancel();
    if (kDebugMode) {
      print("Manually cancel loading process.");
    }
  }

  void _sortElementary(
      ArticleListSortElementary event, Emitter<ArticleListState> emit) {
    var elementaryOnly = defaultArticleList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(ArticleListInitializedState(articleList: elementaryOnly));
  }

  void _sortIntermediate(
      ArticleListSortIntermediate event, Emitter<ArticleListState> emit) {
    var intermediateOnly = defaultArticleList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(ArticleListInitializedState(articleList: intermediateOnly));
  }

  void _sortAdvanced(
      ArticleListSortAdvanced event, Emitter<ArticleListState> emit) {
    var advancedOnly = defaultArticleList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(ArticleListInitializedState(articleList: advancedOnly));
  }

  void _sortAll(ArticleListSortAll event, Emitter<ArticleListState> emit) {
    var all = defaultArticleList;
    emit(ArticleListInitializedState(articleList: all));
  }

  Future<void> _loadAll() async {
    defaultArticleList = await articleRepository.getDefaultStories();
    var onlineStories = await articleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultArticleList.add(story);
      }
    }
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
  }
}
