import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../data/data.dart';
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
abstract class StoryListState {
  List<Story> articleList = [];
  StoryListState({required this.articleList});
}

class StoryListInitialState extends StoryListState {
  StoryListInitialState({required super.articleList});
}

class StoryListUpdatedState extends StoryListState {
  StoryListUpdatedState({required super.articleList});
}

class StoryListErrorState extends StoryListState {
  StoryListErrorState({required super.articleList});
}

/// Bloc
class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  StoryListBloc() : super(StoryListInitialState(articleList: [])) {
    on<StoryListInitial>(_storyListInitial);
    on<StoryListReload>(_storyListReload);
    on<StoryListSortElementary>(_sortElementary);
    on<StoryListSortIntermediate>(_sortIntermediate);
    on<StoryListSortAdvanced>(_sortAdvanced);
    on<StoryListSortAll>(_sortAll);
  }

  final _articleRepository = StoryRepositoryImpl();

  FutureOr<void> _storyListInitial(
      StoryListInitial event, Emitter<StoryListState> emit) async {
    try {
      await _loadAll();
      state.articleList.shuffle();
      emit(StoryListUpdatedState(articleList: state.articleList));
    } catch (e) {
      if (kDebugMode) {
        print("This error happened in StoryListInitial: $e");
      }
      emit(StoryListErrorState(articleList: state.articleList));
    }
  }

  FutureOr<void> _storyListReload(
      StoryListReload event, Emitter<StoryListState> emit) async {
    state.articleList.shuffle();
    emit(StoryListUpdatedState(articleList: state.articleList));
  }

  Future<void> _sortElementary(
      StoryListSortElementary event, Emitter<StoryListState> emit) async {
    await _loadAll();
    var elementaryOnly = state.articleList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: elementaryOnly));
  }

  Future<void> _sortIntermediate(
      StoryListSortIntermediate event, Emitter<StoryListState> emit) async {
    await _loadAll();
    var intermediateOnly = state.articleList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: intermediateOnly));
  }

  Future<void> _sortAdvanced(
      StoryListSortAdvanced event, Emitter<StoryListState> emit) async {
    await _loadAll();
    var advancedOnly = state.articleList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryListUpdatedState(articleList: advancedOnly));
  }

  Future<void> _sortAll(StoryListSortAll event, Emitter<StoryListState> emit) async {
    await _loadAll();
    var all = state.articleList;
    emit(StoryListUpdatedState(articleList: all));
  }

  Future<void> _loadAll() async {
    state.articleList = await _articleRepository.getDefaultStories();
  }
}
