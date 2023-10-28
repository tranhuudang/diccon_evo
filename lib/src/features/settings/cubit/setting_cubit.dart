import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/common/common.dart';

import '../../../common/data/models/setting.dart';
class SettingCubit extends Cubit<Setting> {
  SettingCubit() : super(Properties.defaultSetting);

  void setNumberOfSynonyms(int num) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(numberOfSynonyms: num);
    emit(Properties.defaultSetting);
  }

  void setNumberOfAntonyms(int num) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(numberOfAntonyms: num);
    emit(Properties.defaultSetting);
  }

  void setReadingFontSize(double num) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(readingFontSize: num);
    emit(Properties.defaultSetting);
  }

  void setEssentialLeftMinusOne(int num) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(numberOfEssentialLeft: num - 1);
    emit(Properties.defaultSetting);
  }

  void saveSettings() {
    Properties.saveSettings(Properties.defaultSetting);
    if (kDebugMode) {
      print("New setting is saved with these bellow customs:");
      print("numberOfSynonyms: ${Properties.defaultSetting.numberOfSynonyms}");
      print("numberOfAntonyms: ${Properties.defaultSetting.numberOfAntonyms}");
      print(
          "numberOfEssentialLeft: ${Properties.defaultSetting.numberOfEssentialLeft}");
      print("readingFontSize: ${Properties.defaultSetting.readingFontSize}");
      print(
          "readingFontSizeSliderValue: ${Properties.defaultSetting.readingFontSizeSliderValue}");
      print("language: ${Properties.defaultSetting.language}");
      print("windowsWidth: ${Properties.defaultSetting.windowsWidth}");
      print("windowsHeight: ${Properties.defaultSetting.windowsHeight}");
      print("themeMode: ${Properties.defaultSetting.themeMode}");
    }
  }
}
