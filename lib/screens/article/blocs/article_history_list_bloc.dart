import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import '../../../data/models/article.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/article_repository.dart';

/// States
abstract class ArticleHistoryState {}

abstract class ArticleHistoryActionState extends ArticleHistoryState {}

class ArticleHistoryUninitialState extends ArticleHistoryState {
  final List<Article> articles;
  ArticleHistoryUninitialState({required this.articles});
}

class ArticleHistoryEmptyState extends ArticleHistoryState {}

class ArticleHistoryErrorState extends ArticleHistoryState {}

class ArticleHistoryInitializedState extends ArticleHistoryState {
  final List<Article> articles;
  ArticleHistoryInitializedState({required this.articles});
}

class ArticleHistorySortedState extends ArticleHistoryState {
  final List<Article> articles;
  ArticleHistorySortedState({required this.articles});
}

/// Events
abstract class ArticleHistoryEvent {}

class ArticleHistoryLoad extends ArticleHistoryEvent {}

class ArticleHistorySortAlphabet extends ArticleHistoryEvent {
  final List<Article> articles;
  ArticleHistorySortAlphabet({required this.articles});
}

class ArticleHistorySortReverse extends ArticleHistoryEvent {
  final List<Article> articles;
  ArticleHistorySortReverse({required this.articles});
}

class ArticleHistorySortElementary extends ArticleHistoryEvent {}

class ArticleHistorySortIntermediate extends ArticleHistoryEvent {}

class ArticleHistorySortAdvanced extends ArticleHistoryEvent {}

class ArticleHistoryGetAll extends ArticleHistoryEvent {}

class ArticleHistoryClear extends ArticleHistoryEvent {}

class ArticleHistoryAdd extends ArticleHistoryEvent {
  Article article;
  ArticleHistoryAdd({required this.article});
}

/// Bloc

class ArticleHistoryBloc
    extends Bloc<ArticleHistoryEvent, ArticleHistoryState> {
  ArticleHistoryBloc()
      : super(ArticleHistoryUninitialState(articles: List<Article>.empty())) {
    on<ArticleHistoryLoad>(_loadHistoryList);
    on<ArticleHistorySortAlphabet>(_sortAlphabet);
    on<ArticleHistorySortReverse>(_sortReverse);
    on<ArticleHistorySortElementary>(_sortElementary);
    on<ArticleHistorySortIntermediate>(_sortIntermediate);
    on<ArticleHistorySortAdvanced>(_sortAdvanced);
    on<ArticleHistoryGetAll>(_all);
    on<ArticleHistoryAdd>(_add);
    on<ArticleHistoryClear>(_clear);
  }
  final articleRepository = ArticleRepository();
  var loadedArticleHistoryList = List<Article>.empty();

  FutureOr<void> _loadHistoryList(
      ArticleHistoryLoad event, Emitter<ArticleHistoryState> emit) async {
    try {
      loadedArticleHistoryList = await articleRepository.readArticleHistory();
      if (loadedArticleHistoryList.isEmpty) {
        emit(ArticleHistoryEmptyState());
      } else {
        emit(
            ArticleHistoryInitializedState(articles: loadedArticleHistoryList));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(ArticleHistoryErrorState());
    }
  }

  FutureOr<void> _sortAlphabet(
      ArticleHistorySortAlphabet event, Emitter<ArticleHistoryState> emit) {
    var sorted = List.of(event.articles);
    sorted.sort((a, b) => a.title.compareTo(b.title));

    // If the list is already sorted in alphabet manner, we reverse the list when user click the button twice.
    bool listsAreEqual = const ListEquality().equals(event.articles, sorted);
    if (listsAreEqual) {
      sorted = sorted.reversed.toList();
    }
    emit(ArticleHistorySortedState(articles: sorted));
  }

  FutureOr<void> _sortReverse(
      ArticleHistorySortReverse event, Emitter<ArticleHistoryState> emit) {
    var sorted = event.articles.reversed.toList();
    emit(ArticleHistorySortedState(articles: sorted));
  }

  FutureOr<void> _sortElementary(
      ArticleHistorySortElementary event, Emitter<ArticleHistoryState> emit) {
    var elementaryOnly = loadedArticleHistoryList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(ArticleHistorySortedState(articles: elementaryOnly));
  }

  FutureOr<void> _sortIntermediate(
      ArticleHistorySortIntermediate event, Emitter<ArticleHistoryState> emit) {
    var intermediateOnly = loadedArticleHistoryList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(ArticleHistorySortedState(articles: intermediateOnly));
  }

  FutureOr<void> _sortAdvanced(
      ArticleHistorySortAdvanced event, Emitter<ArticleHistoryState> emit) {
    var advancedOnly = loadedArticleHistoryList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(ArticleHistorySortedState(articles: advancedOnly));
  }

  FutureOr<void> _all(
      ArticleHistoryGetAll event, Emitter<ArticleHistoryState> emit) async {
    emit(ArticleHistorySortedState(articles: loadedArticleHistoryList));
  }

  FutureOr<void> _clear(
      ArticleHistoryClear event, Emitter<ArticleHistoryState> emit) {
    articleRepository.deleteAllArticleHistory();
    emit(ArticleHistoryEmptyState());
  }

  FutureOr<void> _add(
      ArticleHistoryAdd event, Emitter<ArticleHistoryState> emit) async {
    await articleRepository.saveReadArticleToHistory(event.article);
    if (kDebugMode) {
      print("${event.article.title} is added to history file.");
    }
  }
}
