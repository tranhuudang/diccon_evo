import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../common/common.dart';

/// States
abstract class DictionaryPreferencesState{
  List<String> listSelected;
  DictionaryPreferencesState({required this.listSelected});
}
abstract class DictionaryPreferencesActionState extends DictionaryPreferencesState{
  DictionaryPreferencesActionState({required super.listSelected});
}
class DictionaryPreferencesNotifyAboutLimitChoices extends DictionaryPreferencesActionState{
  DictionaryPreferencesNotifyAboutLimitChoices({required super.listSelected});
}
class DictionaryPreferencesInitial extends DictionaryPreferencesState{
  DictionaryPreferencesInitial({required super.listSelected});
}
class DictionaryPreferencesUpdated extends DictionaryPreferencesState{
  DictionaryPreferencesUpdated({required super.listSelected});
}
/// Events
abstract class DictionaryPreferencesEvent{}
class AddItemToSelectedList extends DictionaryPreferencesEvent{
  String itemToAdd;
  AddItemToSelectedList({required this.itemToAdd});
}
class RemoveItemInList extends DictionaryPreferencesEvent{
  String itemToRemove;
  RemoveItemInList({required this.itemToRemove});
}
/// Bloc
class DictionaryPreferencesBloc extends Bloc<DictionaryPreferencesEvent, DictionaryPreferencesState>{
  DictionaryPreferencesBloc(): super(DictionaryPreferencesInitial(listSelected: Properties.defaultSetting.dictionaryResponseSelectedList.split(", "))){
    on<AddItemToSelectedList>(_addItemToSelectedList);
    on<RemoveItemInList>(_removeItemInList);
  }
  FutureOr<void> _addItemToSelectedList (AddItemToSelectedList event, Emitter<DictionaryPreferencesState> emit){
    if(state.listSelected.length >= 7) {
      emit(DictionaryPreferencesNotifyAboutLimitChoices(listSelected: state.listSelected));
    } else {
        state.listSelected.add(event.itemToAdd);
        _saveListSelected();
        emit(DictionaryPreferencesUpdated(listSelected: state.listSelected));
    }
  }
  FutureOr<void> _removeItemInList (RemoveItemInList event, Emitter<DictionaryPreferencesState> emit){
    if(state.listSelected.length >=2) {
        state.listSelected.remove(event.itemToRemove);
        _saveListSelected();
        emit(DictionaryPreferencesUpdated(listSelected: state.listSelected));
    }
  }
  void _saveListSelected() {
    final convertedString =
    state.listSelected.join(", "); // Joins the items with a space
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString));
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(dictionaryResponseSelectedList: convertedString);
  }
}