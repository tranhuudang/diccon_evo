import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common.dart';

/// States
abstract class DictionaryPreferencesState {
  List<String> listSelected;
  List<String> listSelectedEnglish;
  DictionaryPreferencesState(
      {required this.listSelected, required this.listSelectedEnglish});
}

abstract class DictionaryPreferencesActionState
    extends DictionaryPreferencesState {
  DictionaryPreferencesActionState(
      {required super.listSelected, required super.listSelectedEnglish});
}

class DictionaryPreferencesNotifyAboutLimitChoices
    extends DictionaryPreferencesActionState {
  DictionaryPreferencesNotifyAboutLimitChoices(
      {required super.listSelected, required super.listSelectedEnglish});
}

class DictionaryPreferencesInitial extends DictionaryPreferencesState {
  DictionaryPreferencesInitial(
      {required super.listSelected, required super.listSelectedEnglish});
}

class DictionaryPreferencesUpdated extends DictionaryPreferencesState {
  DictionaryPreferencesUpdated(
      {required super.listSelected, required super.listSelectedEnglish});
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

/// Bloc
class DictionaryPreferencesBloc
    extends Bloc<DictionaryPreferencesEvent, DictionaryPreferencesState> {
  DictionaryPreferencesBloc()
      : super(DictionaryPreferencesInitial(
            listSelected: Properties
                .defaultSetting.dictionaryResponseSelectedList
                .split(", "),
            listSelectedEnglish: Properties
                .defaultSetting.dictionaryResponseSelectedListEnglish
                .split(", "))) {
    on<AddItemToSelectedList>(_addItemToSelectedList);
    on<RemoveItemInList>(_removeItemInList);
  }
  FutureOr<void> _addItemToSelectedList(
      AddItemToSelectedList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.listSelected.length >= 7) {
      emit(DictionaryPreferencesNotifyAboutLimitChoices(
          listSelected: state.listSelected,
          listSelectedEnglish: state.listSelectedEnglish));
    } else {
      state.listSelected.add(event.itemToAdd);
      state.listSelectedEnglish.add(event.itemToAdd.i18nEnglish);
      _saveListSelected();
      emit(DictionaryPreferencesUpdated(
          listSelected: state.listSelected,
          listSelectedEnglish: state.listSelectedEnglish));
    }
  }

  FutureOr<void> _removeItemInList(
      RemoveItemInList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.listSelected.length >= 2) {
      state.listSelected.remove(event.itemToRemove);
      state.listSelected.remove(event.itemToRemove.i18nEnglish);
      _saveListSelected();
      emit(DictionaryPreferencesUpdated(
          listSelected: state.listSelected,
          listSelectedEnglish: state.listSelectedEnglish));
    }
  }

  void _saveListSelected() {
    final convertedString =
        state.listSelected.join(", "); // Joins the items with a space
    final convertedStringEnglish =
        state.listSelectedEnglish.join(", "); // Joins the items with a space
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString));
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString);
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedListEnglish: convertedStringEnglish));
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedListEnglish: convertedStringEnglish);
  }
}
