import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/properties.dart';
import '../../../data/handlers/file_handler.dart';
import '../../../data/models/story.dart';
import '../../../data/models/level.dart';
import '../../../data/repositories/story_repository.dart';

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

class StoryListUninitialized extends StoryListState {
  List<Story> defaultStoryList = [];
  StoryListUninitialized(this.defaultStoryList);
}

class StoryListInitializedState extends StoryListState {
  List<Story> articleList = [];
  StoryListInitializedState({required this.articleList});
}

/// Bloc
class StoryListBloc extends Bloc<StoryListEvent, StoryListState> {
  StoryListBloc() : super(StoryListUninitialized([])) {
    on<StoryListInitial>(_getAllStory);
    on<StoryListReload>(_reGetAllStory);
    on<StoryListCancelLoad>(_cancelLoading);
    on<StoryListSortElementary>(_sortElementary);
    on<StoryListSortIntermediate>(_sortIntermediate);
    on<StoryListSortAdvanced>(_sortAdvanced);
    on<StoryListSortAll>(_sortAll);
  }

  final articleRepository = StoryRepository();
  List<Story> defaultStoryList = [];

  FutureOr<void> _getAllStory(
      StoryListInitial event, Emitter<StoryListState> emit) async {
    await _loadAll().timeout(const Duration(seconds: 10), onTimeout: (){
      if (kDebugMode) {
        print("Load all article reach timeout 10 seconds limit.");
      }
    });
    emit(StoryListInitializedState(articleList: defaultStoryList));
  }

  FutureOr<void> _reGetAllStory(
      StoryListReload event, Emitter<StoryListState> emit) async {
    await _reLoadAll().timeout(const Duration(seconds: 10), onTimeout: (){
      if (kDebugMode) {
        print("Reload all article reach timeout 10 seconds limit.");
      }
    });
    emit(StoryListInitializedState(articleList: defaultStoryList));
  }

  FutureOr<void> _cancelLoading(
      StoryListCancelLoad event, Emitter<StoryListState> emit) async {
    //await _cancelableOperation?.cancel();
    if (kDebugMode) {
      print("Manually cancel loading process.");
    }
  }

  void _sortElementary(
      StoryListSortElementary event, Emitter<StoryListState> emit) {
    var elementaryOnly = defaultStoryList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryListInitializedState(articleList: elementaryOnly));
  }

  void _sortIntermediate(
      StoryListSortIntermediate event, Emitter<StoryListState> emit) {
    var intermediateOnly = defaultStoryList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryListInitializedState(articleList: intermediateOnly));
  }

  void _sortAdvanced(
      StoryListSortAdvanced event, Emitter<StoryListState> emit) {
    var advancedOnly = defaultStoryList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryListInitializedState(articleList: advancedOnly));
  }

  void _sortAll(StoryListSortAll event, Emitter<StoryListState> emit) {
    var all = defaultStoryList;
    emit(StoryListInitializedState(articleList: all));
  }

  Future<void> _loadAll() async {
    defaultStoryList = await articleRepository.getDefaultStories();
    var onlineStories = await articleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultStoryList.add(story);
      }
    }
  }

  Future<void> _reLoadAll() async {
    /// Remove downloaded extend-story.json
    await FileHandler(Properties.extendStoryFileName).deleteOnUserData();
    defaultStoryList = await articleRepository.getDefaultStories();
    var onlineStories = await articleRepository.getOnlineStoryList();

    for (var story in onlineStories) {
      if (story.title != "") {
        defaultStoryList.add(story);
      }
    }
  }
}
