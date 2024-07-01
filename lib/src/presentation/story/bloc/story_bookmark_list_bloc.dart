import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class StoryBookmarkSortAlphabet extends StoryBookmarkEvent {
  final List<Story> stories;
  StoryBookmarkSortAlphabet({required this.stories});
}

class FetchStoryBookmarkFromFirestore extends StoryBookmarkEvent {}

class StoryBookmarkSortReverse extends StoryBookmarkEvent {
  final List<Story> stories;
  StoryBookmarkSortReverse({required this.stories});
}

class StoryBookmarkSortElementary extends StoryBookmarkEvent {}

class StoryBookmarkSortIntermediate extends StoryBookmarkEvent {}

class StoryBookmarkSortAdvanced extends StoryBookmarkEvent {}

class StoryBookmarkGetAll extends StoryBookmarkEvent {}

class StoryBookmarkClear extends StoryBookmarkEvent {}
class StoryBookmarkAdd extends StoryBookmarkEvent {
  final Story story;
  StoryBookmarkAdd({required this.story});
}

class StoryBookmarkRemove extends StoryBookmarkEvent {
  final Story story;
  StoryBookmarkRemove({required this.story});
}


/// Bloc

class StoryBookmarkBloc extends Bloc<StoryBookmarkEvent, StoryBookmarkState> {
  StoryBookmarkBloc()
      : super(StoryBookmarkUninitialState(stories: List<Story>.empty())) {
    on<StoryBookmarkSortAlphabet>(_sortAlphabet);
    on<StoryBookmarkSortReverse>(_sortReverse);
    on<StoryBookmarkSortElementary>(_sortElementary);
    on<StoryBookmarkSortIntermediate>(_sortIntermediate);
    on<StoryBookmarkSortAdvanced>(_sortAdvanced);
    on<FetchStoryBookmarkFromFirestore>(_fetchStoryBookmarkFromFirestore);
    on<StoryBookmarkGetAll>(_all);
    on<StoryBookmarkClear>(_clear);
    on<StoryBookmarkAdd>(_storyBookmarkAdd);
    on<StoryBookmarkRemove>(_storyBookmarkRemove);
  }

  final _storyRepository = StoryRepositoryImpl();
  List<Story> _loadedStoryBookmarkList = [];

  FutureOr<void> _fetchStoryBookmarkFromFirestore(
      FetchStoryBookmarkFromFirestore event,
      Emitter<StoryBookmarkState> emit) async {
    if (_loadedStoryBookmarkList.isEmpty) {
      _loadedStoryBookmarkList = await _storyRepository.getStoryBookmark();
      if (_loadedStoryBookmarkList.isEmpty) {
        emit(StoryBookmarkEmptyState());
      } else {
        emit(StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
      }
    } else {
      emit(StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
    }
  }

  FutureOr<void> _sortAlphabet(StoryBookmarkSortAlphabet event,
      Emitter<StoryBookmarkState> emit) {
    var sorted = List.of(event.stories);
    sorted.sort((a, b) => a.title.compareTo(b.title));

    // If the list is already sorted in alphabet manner, we reverse the list when user click the button twice.
    bool listsAreEqual = const ListEquality().equals(event.stories, sorted);
    if (listsAreEqual) {
      sorted = sorted.reversed.toList();
    }
    emit(StoryBookmarkUpdated(stories: sorted));
  }

  FutureOr<void> _sortReverse(StoryBookmarkSortReverse event,
      Emitter<StoryBookmarkState> emit) {
    var sorted = event.stories.reversed.toList();
    emit(StoryBookmarkUpdated(stories: sorted));
  }

  FutureOr<void> _sortElementary(StoryBookmarkSortElementary event,
      Emitter<StoryBookmarkState> emit) {
    var elementaryOnly = _loadedStoryBookmarkList
        .where(
            (element) => element.level == Level.elementary.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: elementaryOnly));
  }

  FutureOr<void> _sortIntermediate(StoryBookmarkSortIntermediate event,
      Emitter<StoryBookmarkState> emit) {
    var intermediateOnly = _loadedStoryBookmarkList
        .where((element) =>
    element.level == Level.intermediate.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: intermediateOnly));
  }

  FutureOr<void> _sortAdvanced(StoryBookmarkSortAdvanced event,
      Emitter<StoryBookmarkState> emit) {
    var advancedOnly = _loadedStoryBookmarkList
        .where((element) => element.level == Level.advanced.toLevelNameString())
        .toList();
    emit(StoryBookmarkUpdated(stories: advancedOnly));
  }

  FutureOr<void> _all(StoryBookmarkGetAll event,
      Emitter<StoryBookmarkState> emit) async {
    emit(StoryBookmarkUpdated(stories: _loadedStoryBookmarkList));
  }

  FutureOr<void> _clear(StoryBookmarkClear event,
      Emitter<StoryBookmarkState> emit) {
    _storyRepository.deleteAllStoryBookmark();
    emit(StoryBookmarkEmptyState());
  }

  FutureOr<void> _storyBookmarkAdd(StoryBookmarkAdd event,
      Emitter<StoryBookmarkState> emit) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {

    } else {
      final storyId = Md5Generator.composeMd5IdForStoryFirebaseDb(
          sentence: event.story.shortDescription);
      final docRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Story')
          .doc(storyId);

      // Create the document if it doesn't exist
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        await docRef.set({'isBookmark': true});
      }

      // Now update the document with the new word
      await docRef.update({
        'isBookmark': true
      });
      await _storyRepository.getStoryBookmark();
    }
  }

  FutureOr<void> _storyBookmarkRemove(StoryBookmarkRemove event,
      Emitter<StoryBookmarkState> emit) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {

    } else {
      final storyId = Md5Generator.composeMd5IdForStoryFirebaseDb(
          sentence: event.story.shortDescription);
      final docRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(userId)
          .collection('Story')
          .doc(storyId);

      // Create the document if it doesn't exist
      final docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {
        await docRef.set({'isBookmark': false});
      }

      // Now update the document with the new word
      await docRef.update({
        'isBookmark': false
      });
      await _storyRepository.getStoryBookmark();
    }
  }
}