import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/common/common.dart';
/// Events
abstract class StoryListEvent {}

class StoryListInitial extends StoryListEvent {}

class StoryListReload extends StoryListEvent {}

class StoryListCancelLoad extends StoryListEvent {}

class StoryListSortElementary extends StoryListEvent {}

class StoryListSortIntermediate extends StoryListEvent {}

class StoryListSortAdvanced extends StoryListEvent {}

class StoryListSortAll extends StoryListEvent {}

/// States
abstract class StoryListState {}

class StoryListUninitialized extends StoryListState {}

class StoryListUpdatedState extends StoryListState {
  List<Story> articleList = [];
  StoryListUpdatedState({required this.articleList});
}

class StoryListErrorState extends StoryListState {}

/// Bloc
class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  StoryListBloc() : super(StoryListUninitialized()) {
    on<StoryListInitial>(_storyListInitial);
    on<StoryListReload>(_storyListReload);
    on<StoryListSortElementary>(_sortElementary);
    on<StoryListSortIntermediate>(_sortIntermediate);
    on<StoryListSortAdvanced>(_sortAdvanced);
    on<StoryListSortAll>(_sortAll);
  }

  final _articleRepository = StoryRepositoryImpl();
  List<Story> _defaultStoryList = [];

  FutureOr<void> _storyListInitial(
      StoryListInitial event, Emitter<StoryListState> emit) async {
    try {
      await _loadAll();
      _defaultStoryList.shuffle();
      emit(StoryListUpdatedState(articleList: _defaultStoryList));
    } catch (e) {
      if (kDebugMode) {
        print("This error happened in StoryListInitial: $e");
      }
      emit(StoryListErrorState());
    }
  }

  FutureOr<void> _storyListReload(
      StoryListReload event, Emitter<StoryListState> emit) async {
    await _loadAll();
    _defaultStoryList.shuffle();
    emit(StoryListUpdatedState(articleList: _defaultStoryList));
  }

  void _sortElementary(
      StoryListSortElementary event, Emitter<StoryListState> emit) {
    var elementaryOnly = _defaultStoryList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: elementaryOnly));
  }

  void _sortIntermediate(
      StoryListSortIntermediate event, Emitter<StoryListState> emit) {
    var intermediateOnly = _defaultStoryList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: intermediateOnly));
  }

  void _sortAdvanced(
      StoryListSortAdvanced event, Emitter<StoryListState> emit) {
    var advancedOnly = _defaultStoryList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: advancedOnly));
  }

  void _sortAll(StoryListSortAll event, Emitter<StoryListState> emit) {
    var all = _defaultStoryList;
    emit(StoryListUpdatedState(articleList: all));
  }

  Future<void> _loadAll() async {
    _defaultStoryList = await _articleRepository.getDefaultStories();
  }
}
