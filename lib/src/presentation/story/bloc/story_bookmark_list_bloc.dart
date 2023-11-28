import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../data/data.dart';

/// States
abstract class StoryBookmarkState {}

abstract class StoryBookmarkActionState extends StoryBookmarkState {}

class StoryBookmarkUninitialState extends StoryBookmarkState {
  final List<Story> stories;
  StoryBookmarkUninitialState({required this.stories});
}

class StoryBookmarkEmptyState extends StoryBookmarkState {}

class StoryBookmarkErrorState extends StoryBookmarkState {}

class StoryBookmarkUpdated extends StoryBookmarkState {
  final List<Story> stories;
  StoryBookmarkUpdated({required this.stories});
}


/// Events
abstract class StoryBookmarkEvent {}

class StoryBookmarkLoad extends StoryBookmarkEvent {}

class StoryBookmarkSortAlphabet extends StoryBookmarkEvent {
  final List<Story> stories;
  StoryBookmarkSortAlphabet({required this.stories});
}

class StoryBookmarkSortReverse extends StoryBookmarkEvent {
  final List<Story> stories;
  StoryBookmarkSortReverse({required this.stories});
}

class StoryBookmarkSortElementary extends StoryBookmarkEvent {}

class StoryBookmarkSortIntermediate extends StoryBookmarkEvent {}

class StoryBookmarkSortAdvanced extends StoryBookmarkEvent {}

class StoryBookmarkGetAll extends StoryBookmarkEvent {}

class StoryBookmarkRemove extends StoryBookmarkEvent {
  Story story;
  StoryBookmarkRemove({required this.story});
}
class StoryBookmarkClear extends StoryBookmarkEvent {}

class StoryBookmarkAdd extends StoryBookmarkEvent {
  Story stories;
  StoryBookmarkAdd({required this.stories});
}

/// Bloc

class StoryBookmarkBloc
    extends Bloc<StoryBookmarkEvent, StoryBookmarkState> {
  StoryBookmarkBloc()
      : super(StoryBookmarkUninitialState(stories: List<Story>.empty())) {
    on<StoryBookmarkLoad>(_loadBookmarkList);
    on<StoryBookmarkSortAlphabet>(_sortAlphabet);
    on<StoryBookmarkSortReverse>(_sortReverse);
    on<StoryBookmarkSortElementary>(_sortElementary);
    on<StoryBookmarkSortIntermediate>(_sortIntermediate);
    on<StoryBookmarkSortAdvanced>(_sortAdvanced);
    on<StoryBookmarkGetAll>(_all);
    on<StoryBookmarkAdd>(_add);
    on<StoryBookmarkClear>(_clear);
    on<StoryBookmarkRemove>(_removeAStory);
  }
  final _storyRepository = StoryRepositoryImpl();
  var _loadedStoryBookmarkList = List<Story>.empty();

  FutureOr<void> _loadBookmarkList(
      StoryBookmarkLoad event, Emitter<StoryBookmarkState> emit) async {
    try {
      _loadedStoryBookmarkList = await _storyRepository.readStoryBookmark();
      if (_loadedStoryBookmarkList.isEmpty) {
        emit(StoryBookmarkEmptyState());
      } else {
        emit(
            StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(StoryBookmarkErrorState());
    }
  }

  FutureOr<void> _sortAlphabet(
      StoryBookmarkSortAlphabet event, Emitter<StoryBookmarkState> emit) {
    var sorted = List.of(event.stories);
    sorted.sort((a, b) => a.title.compareTo(b.title));

    // If the list is already sorted in alphabet manner, we reverse the list when user click the button twice.
    bool listsAreEqual = const ListEquality().equals(event.stories, sorted);
    if (listsAreEqual) {
      sorted = sorted.reversed.toList();
    }
    emit(StoryBookmarkUpdated(stories: sorted));
  }

  FutureOr<void> _sortReverse(
      StoryBookmarkSortReverse event, Emitter<StoryBookmarkState> emit) {
    var sorted = event.stories.reversed.toList();
    emit(StoryBookmarkUpdated(stories: sorted));
  }

  FutureOr<void> _sortElementary(
      StoryBookmarkSortElementary event, Emitter<StoryBookmarkState> emit) {
    var elementaryOnly = _loadedStoryBookmarkList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: elementaryOnly));
  }

  FutureOr<void> _sortIntermediate(
      StoryBookmarkSortIntermediate event, Emitter<StoryBookmarkState> emit) {
    var intermediateOnly = _loadedStoryBookmarkList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: intermediateOnly));
  }

  FutureOr<void> _sortAdvanced(
      StoryBookmarkSortAdvanced event, Emitter<StoryBookmarkState> emit) {
    var advancedOnly = _loadedStoryBookmarkList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: advancedOnly));
  }

  FutureOr<void> _removeAStory(
      StoryBookmarkRemove event, Emitter<StoryBookmarkState> emit) async {
    _storyRepository.removeAStoryInBookmark(event.story);
    //loadedStoryBookmarkList.remove(event.story);
    emit(StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
  }

  FutureOr<void> _all(
      StoryBookmarkGetAll event, Emitter<StoryBookmarkState> emit) async {
    emit(StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
  }

  FutureOr<void> _clear(
      StoryBookmarkClear event, Emitter<StoryBookmarkState> emit) {
    _storyRepository.deleteAllStoryBookmark();
    emit(StoryBookmarkEmptyState());
  }

  FutureOr<void> _add(
      StoryBookmarkAdd event, Emitter<StoryBookmarkState> emit) async {
    await _storyRepository.saveReadStoryToBookmark(event.stories);
    if (kDebugMode) {
      print("${event.stories.title} is added to Bookmark file.");
    }
  }
}
