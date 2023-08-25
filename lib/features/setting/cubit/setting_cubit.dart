


import '../../../properties.dart';
import '../models/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<Setting> {
  SettingCubit() : super(Setting());

  void setNumberOfSynonyms(int num) {
    Properties.defaultNumberOfSynonyms = num;
    saveSettings();
    emit(
        Setting(numberOfSynonyms: num));
  }

  void setNumberOfAntonyms(int num) {
    Properties.defaultNumberOfAntonyms = num;
    saveSettings();
    emit(
        Setting(numberOfAntonyms: num));
  }


  void saveSettings(){
    Properties.saveSettings(
        Properties.defaultNumberOfSynonyms,
        Properties.defaultNumberOfAntonyms);
  }
}