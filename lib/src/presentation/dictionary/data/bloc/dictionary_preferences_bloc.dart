import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/domain.dart';

/// States
abstract class DictionaryPreferencesState {
  List<String> listSelectedVietnamese;
  List<String> listSelectedEnglish;
  DictionaryEngine dictionaryEngine;
  DictionaryPreferencesState(
      {required this.listSelectedVietnamese,
      required this.listSelectedEnglish,
      required this.dictionaryEngine});
}

abstract class DictionaryPreferencesActionState
    extends DictionaryPreferencesState {
  DictionaryPreferencesActionState(
      {required super.listSelectedVietnamese,
      required super.listSelectedEnglish,
      required super.dictionaryEngine});
}

class DictionaryPreferencesNotifyAboutLimitChoices
    extends DictionaryPreferencesActionState {
  DictionaryPreferencesNotifyAboutLimitChoices(
      {required super.listSelectedVietnamese,
      required super.listSelectedEnglish,
      required super.dictionaryEngine});
}

class DictionaryPreferencesInitial extends DictionaryPreferencesState {
  DictionaryPreferencesInitial()
      : super(
            listSelectedVietnamese: Properties
                .instance.settings.dictionaryResponseSelectedListVietnamese
                .split(InAppStrings.splitCharacter),
            listSelectedEnglish: Properties
                .instance.settings.dictionaryResponseSelectedListEnglish
                .split(
              InAppStrings.splitCharacter,
            ),
            dictionaryEngine: Properties
                .instance.settings.dictionaryEngine.toDictionaryEngine);
}

class DictionaryPreferencesUpdated extends DictionaryPreferencesState {
  DictionaryPreferencesUpdated(
      {required super.listSelectedVietnamese,
      required super.listSelectedEnglish,
      required super.dictionaryEngine});
}

/// Events
abstract class DictionaryPreferencesEvent {}

class AddItemToSelectedList extends DictionaryPreferencesEvent {
  String itemToAdd;
  AddItemToSelectedList({required this.itemToAdd});
}

class RemoveItemInList extends DictionaryPreferencesEvent {
  String itemToRemove;
  RemoveItemInList({required this.itemToRemove});
}

class ChangeDictionaryEngine extends DictionaryPreferencesEvent {
  DictionaryEngine dictionaryEngine;
  ChangeDictionaryEngine({required this.dictionaryEngine});
}

/// Bloc
class DictionaryPreferencesBloc
    extends Bloc<DictionaryPreferencesEvent, DictionaryPreferencesState> {
  DictionaryPreferencesBloc() : super(DictionaryPreferencesInitial()) {
    on<AddItemToSelectedList>(_addItemToSelectedList);
    on<RemoveItemInList>(_removeItemInList);
    on<ChangeDictionaryEngine>(_changeDictionaryEngine);
  }
  FutureOr<void> _addItemToSelectedList(
      AddItemToSelectedList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.listSelectedVietnamese.length >= 6) {
      emit(DictionaryPreferencesNotifyAboutLimitChoices(
          listSelectedVietnamese: state.listSelectedVietnamese,
          listSelectedEnglish: state.listSelectedEnglish,
          dictionaryEngine: state.dictionaryEngine));
    } else {
      state.listSelectedVietnamese.add(event.itemToAdd);
      state.listSelectedEnglish.add(event.itemToAdd.i18nEnglish);
      _saveListSelected();
      emit(DictionaryPreferencesUpdated(
          listSelectedVietnamese: state.listSelectedVietnamese,
          listSelectedEnglish: state.listSelectedEnglish,
          dictionaryEngine: state.dictionaryEngine));
    }
  }

  FutureOr<void> _removeItemInList(
      RemoveItemInList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.listSelectedVietnamese.length >= 2) {
      state.listSelectedVietnamese.remove(event.itemToRemove);
      state.listSelectedEnglish.remove(event.itemToRemove.i18nEnglish);
      _saveListSelected();
      emit(DictionaryPreferencesUpdated(
          listSelectedVietnamese: state.listSelectedVietnamese,
          listSelectedEnglish: state.listSelectedEnglish,
          dictionaryEngine: state.dictionaryEngine));
    }
  }

  FutureOr<void> _changeDictionaryEngine(
      ChangeDictionaryEngine event, Emitter<DictionaryPreferencesState> emit) {
    Settings currentSettings = Properties.instance.settings;
    final newSettings = currentSettings.copyWith(
        dictionaryEngine: event.dictionaryEngine.toString());
    print( event.dictionaryEngine.toString());
    print(currentSettings.dictionaryEngine);
    Properties.instance.saveSettings(newSettings);

    emit(DictionaryPreferencesUpdated(
        listSelectedVietnamese: state.listSelectedVietnamese,
        listSelectedEnglish: state.listSelectedEnglish,
        dictionaryEngine: event.dictionaryEngine));
  }

  void _saveListSelected() async {
    Settings currentSettings = Properties.instance.settings;
    final convertedString =
        state.listSelectedVietnamese.join(", "); // Joins the items with a space
    final convertedStringEnglish = state.listSelectedEnglish.join(", ");
    // Save changes in listSelectedOptions
    currentSettings = currentSettings.copyWith(
        dictionaryResponseSelectedListVietnamese: convertedString,
        dictionaryResponseSelectedListEnglish: convertedStringEnglish);
    Properties.instance.saveSettings(currentSettings);
  }
}
