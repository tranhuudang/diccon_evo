import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../data/models/article.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/article_repository.dart';

/// States
abstract class ArticleBookmarkState {}

abstract class ArticleBookmarkActionState extends ArticleBookmarkState {}

class ArticleBookmarkUninitialState extends ArticleBookmarkState {
  final List<Article> articles;
  ArticleBookmarkUninitialState({required this.articles});
}

class ArticleBookmarkEmptyState extends ArticleBookmarkState {}

class ArticleBookmarkErrorState extends ArticleBookmarkState {}

class ArticleBookmarkUpdated extends ArticleBookmarkState {
  final List<Article> articles;
  ArticleBookmarkUpdated({required this.articles});
}


/// Events
abstract class ArticleBookmarkEvent {}

class ArticleBookmarkLoad extends ArticleBookmarkEvent {}

class ArticleBookmarkSortAlphabet extends ArticleBookmarkEvent {
  final List<Article> articles;
  ArticleBookmarkSortAlphabet({required this.articles});
}

class ArticleBookmarkSortReverse extends ArticleBookmarkEvent {
  final List<Article> articles;
  ArticleBookmarkSortReverse({required this.articles});
}

class ArticleBookmarkSortElementary extends ArticleBookmarkEvent {}

class ArticleBookmarkSortIntermediate extends ArticleBookmarkEvent {}

class ArticleBookmarkSortAdvanced extends ArticleBookmarkEvent {}

class ArticleBookmarkGetAll extends ArticleBookmarkEvent {}

class ArticleBookmarkClear extends ArticleBookmarkEvent {}

class ArticleBookmarkAdd extends ArticleBookmarkEvent {
  Article article;
  ArticleBookmarkAdd({required this.article});
}

/// Bloc

class ArticleBookmarkBloc
    extends Bloc<ArticleBookmarkEvent, ArticleBookmarkState> {
  ArticleBookmarkBloc()
      : super(ArticleBookmarkUninitialState(articles: List<Article>.empty())) {
    on<ArticleBookmarkLoad>(_loadBookmarkList);
    on<ArticleBookmarkSortAlphabet>(_sortAlphabet);
    on<ArticleBookmarkSortReverse>(_sortReverse);
    on<ArticleBookmarkSortElementary>(_sortElementary);
    on<ArticleBookmarkSortIntermediate>(_sortIntermediate);
    on<ArticleBookmarkSortAdvanced>(_sortAdvanced);
    on<ArticleBookmarkGetAll>(_all);
    on<ArticleBookmarkAdd>(_add);
    on<ArticleBookmarkClear>(_clear);
  }
  final articleRepository = ArticleRepository();
  var loadedArticleBookmarkList = List<Article>.empty();

  FutureOr<void> _loadBookmarkList(
      ArticleBookmarkLoad event, Emitter<ArticleBookmarkState> emit) async {
    try {
      loadedArticleBookmarkList = await articleRepository.readArticleBookmark();
      if (loadedArticleBookmarkList.isEmpty) {
        emit(ArticleBookmarkEmptyState());
      } else {
        emit(
            ArticleBookmarkUpdated(articles: loadedArticleBookmarkList));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ArticleBookmarkErrorState());
    }
  }

  FutureOr<void> _sortAlphabet(
      ArticleBookmarkSortAlphabet event, Emitter<ArticleBookmarkState> emit) {
    var sorted = List.of(event.articles);
    sorted.sort((a, b) => a.title.compareTo(b.title));

    // If the list is already sorted in alphabet manner, we reverse the list when user click the button twice.
    bool listsAreEqual = const ListEquality().equals(event.articles, sorted);
    if (listsAreEqual) {
      sorted = sorted.reversed.toList();
    }
    emit(ArticleBookmarkUpdated(articles: sorted));
  }

  FutureOr<void> _sortReverse(
      ArticleBookmarkSortReverse event, Emitter<ArticleBookmarkState> emit) {
    var sorted = event.articles.reversed.toList();
    emit(ArticleBookmarkUpdated(articles: sorted));
  }

  FutureOr<void> _sortElementary(
      ArticleBookmarkSortElementary event, Emitter<ArticleBookmarkState> emit) {
    var elementaryOnly = loadedArticleBookmarkList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(ArticleBookmarkUpdated(articles: elementaryOnly));
  }

  FutureOr<void> _sortIntermediate(
      ArticleBookmarkSortIntermediate event, Emitter<ArticleBookmarkState> emit) {
    var intermediateOnly = loadedArticleBookmarkList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(ArticleBookmarkUpdated(articles: intermediateOnly));
  }

  FutureOr<void> _sortAdvanced(
      ArticleBookmarkSortAdvanced event, Emitter<ArticleBookmarkState> emit) {
    var advancedOnly = loadedArticleBookmarkList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(ArticleBookmarkUpdated(articles: advancedOnly));
  }

  FutureOr<void> _all(
      ArticleBookmarkGetAll event, Emitter<ArticleBookmarkState> emit) async {
    emit(ArticleBookmarkUpdated(articles: loadedArticleBookmarkList));
  }

  FutureOr<void> _clear(
      ArticleBookmarkClear event, Emitter<ArticleBookmarkState> emit) {
    articleRepository.deleteAllArticleBookmark();
    emit(ArticleBookmarkEmptyState());
  }

  FutureOr<void> _add(
      ArticleBookmarkAdd event, Emitter<ArticleBookmarkState> emit) async {
    await articleRepository.saveReadArticleToBookmark(event.article);
    if (kDebugMode) {
      print("${event.article.title} is added to Bookmark file.");
    }
  }
}
