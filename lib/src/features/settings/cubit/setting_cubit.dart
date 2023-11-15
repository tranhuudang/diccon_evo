import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/common/common.dart';
class SettingCubit extends Cubit<Settings> {
  SettingCubit() : super(Properties.instance.settings);

  void setNumberOfSynonyms(int num) {
    Properties.instance.settings =
        Properties.instance.settings.copyWith(numberOfSynonyms: num);
    emit(Properties.instance.settings);
  }

  void setNumberOfAntonyms(int num) {
    Properties.instance.settings =
        Properties.instance.settings.copyWith(numberOfAntonyms: num);
    emit(Properties.instance.settings);
  }

  void setReadingFontSize(double num) {
    Properties.instance.settings =
        Properties.instance.settings.copyWith(readingFontSize: num);
    emit(Properties.instance.settings);
  }

  void setEssentialLeftMinusOne(int num) {
    Properties.instance.settings =
        Properties.instance.settings.copyWith(numberOfEssentialLeft: num - 1);
    emit(Properties.instance.settings);
  }

  void saveSettings() {
    Properties.instance.saveSettings(Properties.instance.settings);
    if (kDebugMode) {
      print("New setting is saved with these bellow customs:");
      print("numberOfSynonyms: ${Properties.instance.settings.numberOfSynonyms}");
      print("numberOfAntonyms: ${Properties.instance.settings.numberOfAntonyms}");
      print(
          "numberOfEssentialLeft: ${Properties.instance.settings.numberOfEssentialLeft}");
      print("readingFontSize: ${Properties.instance.settings.readingFontSize}");
      print(
          "readingFontSizeSliderValue: ${Properties.instance.settings.readingFontSizeSliderValue}");
      print("language: ${Properties.instance.settings.language}");
      print("windowsWidth: ${Properties.instance.settings.windowsWidth}");
      print("windowsHeight: ${Properties.instance.settings.windowsHeight}");
      print("themeMode: ${Properties.instance.settings.themeMode}");
    }
  }
}
