import 'package:flutter/material.dart';
import '../../domain/domain.dart';
import '../../core/core.dart';

class DefaultSettings{
  static const String appName = "Diccon";
  static const Size defaultWindowsSize = Size(620, 670);
  static const Size minWindowsSize = Size(620, 600);
  static const Size maxWindowsSize = Size(5000, 10000);
  static const double overflowHeight = 745;
  static const dictionaryResponseVietnameseConstant= 'Phiên âm, Định nghĩa, Ví dụ';
  static const dictionaryResponseEnglishConstant = 'Pronunciation, Definition, Examples';
  static final Settings settings = Settings(
    dictionaryEngine: DictionaryEngine.stream.name,
    numberOfSynonyms: 10,
    numberOfAntonyms: 10,
    readingFontSize: 16,
    numberOfEssentialLeft: 1848,
    language: 'System default',
    dictionarySpecializedVietnamese: '',
    dictionarySpecializedEnglish: '',
    readingFontSizeSliderValue: 0.2,
    windowsWidth: defaultWindowsSize.width,
    windowsHeight: defaultWindowsSize.height,
    themeMode: 'ThemeMode.system',
    openAppCount: 0,
    themeColor: Colors.blue.value,
    enableAdaptiveTheme: true,
    translationLanguageTarget: 'autoDetect',
    selectedTab: RoutePath.readingChamber, continueWithoutLogin: false
  );
}