import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../common/data/data_providers/history_manager.dart';
import 'package:diccon_evo/src/common/common.dart';

/// State
abstract class WordHistoryState {
  List<String> words;
  bool? isEdit;

  WordHistoryState({required this.words, this.isEdit = false});
}

class WordHistoryInitial extends WordHistoryState {
  WordHistoryInitial({required super.words});
}

class WordHistoryUpdated extends WordHistoryState {
  WordHistoryUpdated({required super.words, super.isEdit});
}

/// Events
abstract class WordHistoryEvent {}

class InitialWordHistory extends WordHistoryEvent {}

class ClearAllWordHistory extends WordHistoryEvent {}

class SortReverseWordHistory extends WordHistoryEvent {}

class SortAlphabetWordHistory extends WordHistoryEvent {}
class WordHistoryEditMode extends WordHistoryEvent {}
class CloseWordHistoryEditMode extends WordHistoryEvent {}

class RemoveWordOutOfHistory extends WordHistoryEvent {
  final String wordToRemove;
  RemoveWordOutOfHistory({required this.wordToRemove});
}
class AddWordToHistory extends WordHistoryEvent{
  final String providedWord;
  AddWordToHistory({required this.providedWord});
}
/// Bloc
class WordHistoryBloc extends Bloc<WordHistoryEvent, WordHistoryState> {
  WordHistoryBloc() : super(WordHistoryInitial(words: [])) {
    on<InitialWordHistory>(_initialWordHistory);
    on<ClearAllWordHistory>(_clearAllWordHistory);
    on<RemoveWordOutOfHistory>(_removeWordOutOfHistory);
    on<SortReverseWordHistory>(_sortReverseWordHistory);
    on<SortAlphabetWordHistory>(_sortAlphabetWordHistory);
    on<AddWordToHistory>(_addWordToHistory);
    on<WordHistoryEditMode>(_wordHistoryEditMode);
    on<CloseWordHistoryEditMode>(_closeWordHistoryEditMode);
  }

  FutureOr<void> _wordHistoryEditMode(
      WordHistoryEditMode event, Emitter<WordHistoryState> emit) async {
    emit(WordHistoryUpdated(words: state.words, isEdit: true));
  }
  FutureOr<void> _closeWordHistoryEditMode(
      CloseWordHistoryEditMode event, Emitter<WordHistoryState> emit) async {
    emit(WordHistoryUpdated(words: state.words, isEdit: false));
  }

  FutureOr<void> _initialWordHistory(
      InitialWordHistory event, Emitter<WordHistoryState> emit) async {
    state.words = await HistoryManager.readWordHistory();
    emit(WordHistoryUpdated(words: state.words));
  }

  FutureOr<void> _sortAlphabetWordHistory(
      SortAlphabetWordHistory event, Emitter<WordHistoryState> emit) {
    state.words.sort((a, b) => a.compareTo(b));
    emit(WordHistoryUpdated(words: state.words));
  }

  FutureOr<void> _sortReverseWordHistory(
      SortReverseWordHistory event, Emitter<WordHistoryState> emit) {
    var sorted = state.words.reversed.toList();
    emit(WordHistoryUpdated(words: sorted));
  }

  FutureOr<void> _addWordToHistory(
      AddWordToHistory event, Emitter<WordHistoryState> emit) async {
    state.words.add(event.providedWord);
    await HistoryManager.saveWordToHistory(event.providedWord);
    emit(WordHistoryUpdated(words: state.words));
  }
  FutureOr<void> _removeWordOutOfHistory(
      RemoveWordOutOfHistory event, Emitter<WordHistoryState> emit) async {
    state.words.removeWhere((element) => element == event.wordToRemove);
    await HistoryManager.removeWordOutOfHistory(event.wordToRemove);
    emit(WordHistoryUpdated(words: state.words, isEdit: true));
  }

  void _clearAllWordHistory(
      ClearAllWordHistory event, Emitter<WordHistoryState> emit) {
    FileHandler(PropertiesConstants.wordHistoryFileName).deleteOnUserData();
    state.words.clear();
    emit(WordHistoryUpdated(words: state.words));
  }
}
