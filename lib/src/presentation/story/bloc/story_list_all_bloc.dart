import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../data/data.dart';
/// Events
abstract class StoryListAllEvent {}

class StoryListAllInitial extends StoryListAllEvent {}

class StoryListAllReload extends StoryListAllEvent {}

class StoryListAllCancelLoad extends StoryListAllEvent {}

class StoryListAllSortElementary extends StoryListAllEvent {}

class StoryListAllSortIntermediate extends StoryListAllEvent {}

class StoryListAllSortAdvanced extends StoryListAllEvent {}

class StoryListAllSortAll extends StoryListAllEvent {}

/// States
abstract class StoryListAllState {
  List<Story> articleList = [];
  StoryListAllState({required this.articleList});
}

class StoryListAllInitialState extends StoryListAllState {
  StoryListAllInitialState({required super.articleList});
}

class StoryListAllUpdatedState extends StoryListAllState {
  StoryListAllUpdatedState({required super.articleList});
}

class StoryListAllErrorState extends StoryListAllState {
  StoryListAllErrorState({required super.articleList});
}

/// Bloc
class StoryListAllBloc extends Bloc<StoryListAllEvent, StoryListAllState> {
  StoryListAllBloc() : super(StoryListAllInitialState(articleList: [])) {
    on<StoryListAllInitial>(_storyListInitial);
    on<StoryListAllReload>(_storyListReload);
    on<StoryListAllSortElementary>(_sortElementary);
    on<StoryListAllSortIntermediate>(_sortIntermediate);
    on<StoryListAllSortAdvanced>(_sortAdvanced);
    on<StoryListAllSortAll>(_sortAll);
  }

  final _articleRepository = StoryRepositoryImpl();

  FutureOr<void> _storyListInitial(
      StoryListAllInitial event, Emitter<StoryListAllState> emit) async {
    try {
      await _loadAll();
      state.articleList.shuffle();
      emit(StoryListAllUpdatedState(articleList: state.articleList));
    } catch (e) {
      if (kDebugMode) {
        print("This error happened in StoryListInitial: $e");
      }
      emit(StoryListAllErrorState(articleList: state.articleList));
    }
  }

  FutureOr<void> _storyListReload(
      StoryListAllReload event, Emitter<StoryListAllState> emit) async {
    state.articleList.shuffle();
    emit(StoryListAllUpdatedState(articleList: state.articleList));
  }

  Future<void> _sortElementary(
      StoryListAllSortElementary event, Emitter<StoryListAllState> emit) async {
    await _loadAll();
    var elementaryOnly = state.articleList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryListAllUpdatedState(articleList: elementaryOnly));
  }

  Future<void> _sortIntermediate(
      StoryListAllSortIntermediate event, Emitter<StoryListAllState> emit) async {
    await _loadAll();
    var intermediateOnly = state.articleList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryListAllUpdatedState(articleList: intermediateOnly));
  }

  Future<void> _sortAdvanced(
      StoryListAllSortAdvanced event, Emitter<StoryListAllState> emit) async {
    await _loadAll();
    var advancedOnly = state.articleList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryListAllUpdatedState(articleList: advancedOnly));
  }

  Future<void> _sortAll(StoryListAllSortAll event, Emitter<StoryListAllState> emit) async {
    await _loadAll();
    var all = state.articleList;
    emit(StoryListAllUpdatedState(articleList: all));
  }

  Future<void> _loadAll() async {
    state.articleList = await _articleRepository.getDefaultStories();
  }
}
