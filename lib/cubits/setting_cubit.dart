


import '../global.dart';
import '../models/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<Setting> {
  SettingCubit() : super(Setting());

  void setNumberOfSynonyms(int num) {
    Global.defaultNumberOfSynonyms = num;
    saveSettings();
    emit(
        Setting(numberOfSynonyms: num));
  }

  void setNumberOfAntonyms(int num) {
    Global.defaultNumberOfAntonyms = num;
    saveSettings();
    emit(
        Setting(numberOfAntonyms: num));
  }

  void setReadingFontSize(double num) {
    Global.defaultReadingFontSize = num;
    saveSettings();
    emit(Setting(readingFontSize: num));
  }

  void saveSettings(){
    Global.saveSettings(
        Global.defaultReadingFontSize,
        Global.defaultReadingFontSizeSliderValue,
        Global.defaultNumberOfSynonyms,
        Global.defaultNumberOfAntonyms);
  }
}