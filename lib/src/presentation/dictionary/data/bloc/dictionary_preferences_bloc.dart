import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import '../../../../domain/domain.dart';

class DictionaryPreferencesParams {
  final String specializedVietnamese;
  final String specializedEnglish;
  final DictionaryEngine dictionaryEngine;

  DictionaryPreferencesParams({
    required this.specializedVietnamese,
    required this.specializedEnglish,
    required this.dictionaryEngine,
  });

  DictionaryPreferencesParams copyWith({
    String? specializedVietnamese,
    String? specializedEnglish,
    DictionaryEngine? dictionaryEngine,
  }) {
    return DictionaryPreferencesParams(
      specializedVietnamese: specializedVietnamese ?? this.specializedVietnamese,
      specializedEnglish: specializedEnglish ?? this.specializedEnglish,
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
      specializedVietnamese: Properties
          .instance.settings.dictionarySpecializedVietnamese,
      specializedEnglish: Properties
          .instance.settings.dictionarySpecializedEnglish,
      dictionaryEngine: Properties.instance.settings.dictionaryEngine.toDictionaryEngine,
    ),
  );
}

class DictionaryPreferencesUpdated extends DictionaryPreferencesState {
  DictionaryPreferencesUpdated({required super.params});
}

/// Events
abstract class DictionaryPreferencesEvent {}

class AddItemToSpecialized extends DictionaryPreferencesEvent {
  final String itemToAdd;
  AddItemToSpecialized({required this.itemToAdd});
}

class RemoveDictionarySpecialized extends DictionaryPreferencesEvent {
  RemoveDictionarySpecialized();
}

class ChangeDictionaryEngine extends DictionaryPreferencesEvent {
  final DictionaryEngine dictionaryEngine;
  ChangeDictionaryEngine({required this.dictionaryEngine});
}

/// Bloc
class DictionaryPreferencesBloc extends Bloc<DictionaryPreferencesEvent, DictionaryPreferencesState> {
  DictionaryPreferencesBloc() : super(DictionaryPreferencesInitial()) {
    on<AddItemToSpecialized>(_addItemToSpecialized);
    on<RemoveDictionarySpecialized>(_removeDictionarySpecialized);
    on<ChangeDictionaryEngine>(_changeDictionaryEngine);
  }

  FutureOr<void> _addItemToSpecialized(AddItemToSpecialized event, Emitter<DictionaryPreferencesState> emit) {
    // only accept to have 1 selection in specialized meaning
      final updatedParams = state.params.copyWith(
        specializedVietnamese: event.itemToAdd,
        specializedEnglish: event.itemToAdd.i18nEnglish,
      );
      _saveSpecialized(updatedParams);
      emit(DictionaryPreferencesUpdated(params: updatedParams));
  }

  FutureOr<void> _removeDictionarySpecialized(RemoveDictionarySpecialized event, Emitter<DictionaryPreferencesState> emit) {
    // only accept to have 1 selection in specialized meaning
    if (state.params.specializedVietnamese.isNotEmpty) {
      final updatedParams = state.params.copyWith(
        specializedVietnamese: '',
        specializedEnglish: '',
      );
      Settings currentSettings = Properties.instance.settings;
      currentSettings = currentSettings.copyWith(
        dictionarySpecializedVietnamese: '',
        dictionarySpecializedEnglish: '',
      );
      Properties.instance.saveSettings(currentSettings);
      emit(DictionaryPreferencesUpdated(params: updatedParams));
    }
  }

  FutureOr<void> _changeDictionaryEngine(ChangeDictionaryEngine event, Emitter<DictionaryPreferencesState> emit) {
    Settings currentSettings = Properties.instance.settings;
    final newSettings = currentSettings.copyWith(dictionaryEngine: event.dictionaryEngine.name);
    Properties.instance.saveSettings(newSettings);
    final updatedParams = state.params.copyWith(dictionaryEngine: event.dictionaryEngine);
    emit(DictionaryPreferencesUpdated(params: updatedParams));
  }

  void _saveSpecialized(DictionaryPreferencesParams params) async {
    Settings currentSettings = Properties.instance.settings;
    currentSettings = currentSettings.copyWith(
      dictionarySpecializedVietnamese: params.specializedVietnamese,
      dictionarySpecializedEnglish: params.specializedEnglish,
    );
    Properties.instance.saveSettings(currentSettings);
  }
}
