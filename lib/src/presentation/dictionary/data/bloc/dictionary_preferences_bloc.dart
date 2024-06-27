import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/domain.dart';

class DictionaryPreferencesParams {
  final List<String> listSelectedVietnamese;
  final List<String> listSelectedEnglish;
  final DictionaryEngine dictionaryEngine;

  DictionaryPreferencesParams({
    required this.listSelectedVietnamese,
    required this.listSelectedEnglish,
    required this.dictionaryEngine,
  });

  DictionaryPreferencesParams copyWith({
    List<String>? listSelectedVietnamese,
    List<String>? listSelectedEnglish,
    DictionaryEngine? dictionaryEngine,
  }) {
    return DictionaryPreferencesParams(
      listSelectedVietnamese: listSelectedVietnamese ?? this.listSelectedVietnamese,
      listSelectedEnglish: listSelectedEnglish ?? this.listSelectedEnglish,
      dictionaryEngine: dictionaryEngine ?? this.dictionaryEngine,
    );
  }
}

/// States
abstract class DictionaryPreferencesState {
  final DictionaryPreferencesParams params;

  DictionaryPreferencesState({required this.params});
}

abstract class DictionaryPreferencesActionState extends DictionaryPreferencesState {
  DictionaryPreferencesActionState({required super.params});
}

class DictionaryPreferencesNotifyAboutLimitChoices extends DictionaryPreferencesActionState {
  DictionaryPreferencesNotifyAboutLimitChoices({required super.params});
}

class DictionaryPreferencesInitial extends DictionaryPreferencesState {
  DictionaryPreferencesInitial()
      : super(
    params: DictionaryPreferencesParams(
      listSelectedVietnamese: Properties
          .instance.settings.dictionaryResponseSelectedListVietnamese
          .split(InAppStrings.splitCharacter),
      listSelectedEnglish: Properties
          .instance.settings.dictionaryResponseSelectedListEnglish
          .split(InAppStrings.splitCharacter),
      dictionaryEngine: Properties.instance.settings.dictionaryEngine.toDictionaryEngine,
    ),
  );
}

class DictionaryPreferencesUpdated extends DictionaryPreferencesState {
  DictionaryPreferencesUpdated({required super.params});
}

/// Events
abstract class DictionaryPreferencesEvent {}

class AddItemToSelectedList extends DictionaryPreferencesEvent {
  final String itemToAdd;
  AddItemToSelectedList({required this.itemToAdd});
}

class RemoveItemInList extends DictionaryPreferencesEvent {
  final String itemToRemove;
  RemoveItemInList({required this.itemToRemove});
}

class ChangeDictionaryEngine extends DictionaryPreferencesEvent {
  final DictionaryEngine dictionaryEngine;
  ChangeDictionaryEngine({required this.dictionaryEngine});
}

/// Bloc
class DictionaryPreferencesBloc extends Bloc<DictionaryPreferencesEvent, DictionaryPreferencesState> {
  DictionaryPreferencesBloc() : super(DictionaryPreferencesInitial()) {
    on<AddItemToSelectedList>(_addItemToSelectedList);
    on<RemoveItemInList>(_removeItemInList);
    on<ChangeDictionaryEngine>(_changeDictionaryEngine);
  }

  FutureOr<void> _addItemToSelectedList(AddItemToSelectedList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.params.listSelectedVietnamese.length >= 6) {
      emit(DictionaryPreferencesNotifyAboutLimitChoices(params: state.params));
    } else {
      final updatedParams = state.params.copyWith(
        listSelectedVietnamese: List.from(state.params.listSelectedVietnamese)..add(event.itemToAdd),
        listSelectedEnglish: List.from(state.params.listSelectedEnglish)..add(event.itemToAdd.i18nEnglish),
      );
      _saveListSelected(updatedParams);
      emit(DictionaryPreferencesUpdated(params: updatedParams));
    }
  }

  FutureOr<void> _removeItemInList(RemoveItemInList event, Emitter<DictionaryPreferencesState> emit) {
    if (state.params.listSelectedVietnamese.length >= 2) {
      final updatedParams = state.params.copyWith(
        listSelectedVietnamese: List.from(state.params.listSelectedVietnamese)..remove(event.itemToRemove),
        listSelectedEnglish: List.from(state.params.listSelectedEnglish)..remove(event.itemToRemove.i18nEnglish),
      );
      _saveListSelected(updatedParams);
      emit(DictionaryPreferencesUpdated(params: updatedParams));
    }
  }

  FutureOr<void> _changeDictionaryEngine(ChangeDictionaryEngine event, Emitter<DictionaryPreferencesState> emit) {
    Settings currentSettings = Properties.instance.settings;
    final newSettings = currentSettings.copyWith(dictionaryEngine: event.dictionaryEngine.name);
    print(event.dictionaryEngine.toString());
    print(currentSettings.dictionaryEngine);
    Properties.instance.saveSettings(newSettings);
    print(currentSettings.dictionaryEngine);

    final updatedParams = state.params.copyWith(dictionaryEngine: event.dictionaryEngine);
    emit(DictionaryPreferencesUpdated(params: updatedParams));
  }

  void _saveListSelected(DictionaryPreferencesParams params) async {
    Settings currentSettings = Properties.instance.settings;
    final convertedString = params.listSelectedVietnamese.join(", ");
    final convertedStringEnglish = params.listSelectedEnglish.join(", ");
    currentSettings = currentSettings.copyWith(
      dictionaryResponseSelectedListVietnamese: convertedString,
      dictionaryResponseSelectedListEnglish: convertedStringEnglish,
    );
    Properties.instance.saveSettings(currentSettings);
  }
}
