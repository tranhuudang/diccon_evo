import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/essential_manager.dart';
import '../../../data/models/essential_word.dart';

/// Events
abstract class LearningEvent {}

class InitialLearningEssential extends LearningEvent {
  final String topic;
  InitialLearningEssential({required this.topic});
}

class GoToPreviousCard extends LearningEvent {}

class GoToNextCard extends LearningEvent {}

class OnPageChanged extends LearningEvent {
  final int currentPageIndex;
  OnPageChanged({required this.currentPageIndex});
}

class AddToFavourite extends LearningEvent {
  final EssentialWord word;
  AddToFavourite({required this.word});
}

class GotItTips extends LearningEvent {}

class RemoveFromFavourite extends LearningEvent {
  final EssentialWord word;
  RemoveFromFavourite({required this.word});
}

/// State
abstract class LearningState {}

class LearningUninitializedState extends LearningState {}

class LearningUpdatedState extends LearningState {
  final List<EssentialWord> listEssentialWord;
  final bool isCurrentWordFavourite;
  LearningUpdatedState(
      {required this.isCurrentWordFavourite, required this.listEssentialWord});
}

class LearningLoadingState extends LearningState {}

class LearningErrorState extends LearningState {}

/// Bloc
class LearningBloc extends Bloc<LearningEvent, LearningState> {
  LearningBloc() : super(LearningUninitializedState()) {
    on<InitialLearningEssential>(_initial);
    on<GoToNextCard>(_goToNextCard);
    on<GoToPreviousCard>(_goToPreviousCard);
    on<OnPageChanged>(_onPageChanged);
    on<GotItTips>(_gotItTips);
    on<AddToFavourite>(_addToFavourite);
    on<RemoveFromFavourite>(_removeFromFavourite);
  }
  final pageViewController = PageController();
  List<EssentialWord> _listFavouriteEssential = [];
  List<EssentialWord> listEssentialWordByTopic = [];

  FutureOr<void> _initial(
      InitialLearningEssential event, Emitter<LearningState> emit) async {
    emit(LearningLoadingState());
    _listFavouriteEssential = await EssentialWordRepository.readFavouriteEssential();
    listEssentialWordByTopic =
        await EssentialWordRepository.loadEssentialData(event.topic);
    if (_listFavouriteEssential.any(
        (element) => element.english == listEssentialWordByTopic[0].english)) {
      emit(LearningUpdatedState(
          listEssentialWord: listEssentialWordByTopic,
          isCurrentWordFavourite: true));
    } else {
      emit(LearningUpdatedState(
          listEssentialWord: listEssentialWordByTopic,
          isCurrentWordFavourite: false));
    }
  }

  FutureOr<void> _goToPreviousCard(
      GoToPreviousCard event, Emitter<LearningState> emit) {
    pageViewController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  FutureOr<void> _goToNextCard(
      GoToNextCard event, Emitter<LearningState> emit) {
    pageViewController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  FutureOr<void> _onPageChanged(
      OnPageChanged event, Emitter<LearningState> emit) {
    var currentWord = listEssentialWordByTopic[event.currentPageIndex];
    // check to see if current word is a favourite word
    if (_listFavouriteEssential
        .any((element) => element.english == currentWord.english)) {
      emit(LearningUpdatedState(
          listEssentialWord: listEssentialWordByTopic,
          isCurrentWordFavourite: true));
    } else {
      emit(LearningUpdatedState(
          listEssentialWord: listEssentialWordByTopic,
          isCurrentWordFavourite: false));
    }
  }

  FutureOr<void> _gotItTips(GotItTips event, Emitter<LearningState> emit) {}
  FutureOr<void> _addToFavourite(
      AddToFavourite event, Emitter<LearningState> emit) {
    _listFavouriteEssential.add(event.word);
    EssentialWordRepository.saveEssentialWordToFavourite(event.word);
    emit(LearningUpdatedState(isCurrentWordFavourite: true, listEssentialWord: listEssentialWordByTopic));
  }

  FutureOr<void> _removeFromFavourite(
      RemoveFromFavourite event, Emitter<LearningState> emit) {
    _listFavouriteEssential.remove(event.word);
    EssentialWordRepository.removeEssentialWordOutOfFavourite(event.word);
    emit(LearningUpdatedState(isCurrentWordFavourite: false, listEssentialWord: listEssentialWordByTopic));
  }

}
