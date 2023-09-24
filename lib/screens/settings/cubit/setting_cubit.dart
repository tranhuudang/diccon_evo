import 'package:flutter/foundation.dart';
import '../../../config/properties.dart';
import '../../../data/models/setting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void setLanguage(String language) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(language: language);
    emit(Properties.defaultSetting);
  }

  void setThemeMode(String themeMode) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(themeMode: themeMode);
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
