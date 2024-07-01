import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import '../../../data/data.dart';

/// States
abstract class StoryHistoryState {}

abstract class StoryHistoryActionState extends StoryHistoryState {}

class StoryHistoryUninitialState extends StoryHistoryState {
  final List<Story> stories;
  StoryHistoryUninitialState({required this.stories});
}

class StoryHistoryEmptyState extends StoryHistoryState {}

class StoryHistoryErrorState extends StoryHistoryState {}

class StoryHistoryUpdated extends StoryHistoryState {
  final List<Story> stories;
  StoryHistoryUpdated({required this.stories});
}

/// Events
abstract class StoryHistoryEvent {}

class StoryHistorySortAlphabet extends StoryHistoryEvent {
  final List<Story> stories;
  StoryHistorySortAlphabet({required this.stories});
}

class FetchStoryHistoryFromFirestore extends StoryHistoryEvent {}

class StoryHistorySortReverse extends StoryHistoryEvent {
  final List<Story> stories;
  StoryHistorySortReverse({required this.stories});
}

class StoryHistorySortElementary extends StoryHistoryEvent {}

class StoryHistorySortIntermediate extends StoryHistoryEvent {}

class StoryHistorySortAdvanced extends StoryHistoryEvent {}

class StoryHistoryGetAll extends StoryHistoryEvent {}

class StoryHistoryClear extends StoryHistoryEvent {}


/// Bloc

class StoryHistoryBloc extends Bloc<StoryHistoryEvent, StoryHistoryState> {
  StoryHistoryBloc()
      : super(StoryHistoryUninitialState(stories: List<Story>.empty())) {
    on<StoryHistorySortAlphabet>(_sortAlphabet);
    on<StoryHistorySortReverse>(_sortReverse);
    on<StoryHistorySortElementary>(_sortElementary);
    on<StoryHistorySortIntermediate>(_sortIntermediate);
    on<StoryHistorySortAdvanced>(_sortAdvanced);
    on<FetchStoryHistoryFromFirestore>(_fetchStoryHistoryFromFirestore);
    on<StoryHistoryGetAll>(_all);
    on<StoryHistoryClear>(_clear);
  }
  final _storyRepository = StoryRepositoryImpl();
  List<Story> _loadedStoryHistoryList = [];

  FutureOr<void> _fetchStoryHistoryFromFirestore(
      FetchStoryHistoryFromFirestore event,
      Emitter<StoryHistoryState> emit) async {
    if (_loadedStoryHistoryList.isEmpty) {
      _loadedStoryHistoryList = await _storyRepository.getStoryHistory();
      if (_loadedStoryHistoryList.isEmpty) {
        emit(StoryHistoryEmptyState());
      } else {
        emit(StoryHistoryUpdated(stories: _loadedStoryHistoryList));
      }
    } else {
      emit(StoryHistoryUpdated(stories: _loadedStoryHistoryList));
    }
  }

  FutureOr<void> _sortAlphabet(
      StoryHistorySortAlphabet event, Emitter<StoryHistoryState> emit) {
    var sorted = List.of(event.stories);
    sorted.sort((a, b) => a.title.compareTo(b.title));

    // If the list is already sorted in alphabet manner, we reverse the list when user click the button twice.
    bool listsAreEqual = const ListEquality().equals(event.stories, sorted);
    if (listsAreEqual) {
      sorted = sorted.reversed.toList();
    }
    emit(StoryHistoryUpdated(stories: sorted));
  }

  FutureOr<void> _sortReverse(
      StoryHistorySortReverse event, Emitter<StoryHistoryState> emit) {
    var sorted = event.stories.reversed.toList();
    emit(StoryHistoryUpdated(stories: sorted));
  }

  FutureOr<void> _sortElementary(
      StoryHistorySortElementary event, Emitter<StoryHistoryState> emit) {
    var elementaryOnly = _loadedStoryHistoryList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryHistoryUpdated(stories: elementaryOnly));
  }

  FutureOr<void> _sortIntermediate(
      StoryHistorySortIntermediate event, Emitter<StoryHistoryState> emit) {
    var intermediateOnly = _loadedStoryHistoryList
        .where((element) =>
            element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryHistoryUpdated(stories: intermediateOnly));
  }

  FutureOr<void> _sortAdvanced(
      StoryHistorySortAdvanced event, Emitter<StoryHistoryState> emit) {
    var advancedOnly = _loadedStoryHistoryList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryHistoryUpdated(stories: advancedOnly));
  }

  FutureOr<void> _all(
      StoryHistoryGetAll event, Emitter<StoryHistoryState> emit) async {
    emit(StoryHistoryUpdated(stories: _loadedStoryHistoryList));
  }

  FutureOr<void> _clear(
      StoryHistoryClear event, Emitter<StoryHistoryState> emit) {
    _storyRepository.deleteAllStoryHistory();
    emit(StoryHistoryEmptyState());
  }
}
