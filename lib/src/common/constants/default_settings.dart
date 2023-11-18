import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

class DefaultSettings{
  static const String appName = "Diccon";
  static const int version = 487;
  static const Size minWindowsSize = Size(400, 600);
  static const Size maxWindowsSize = Size(5000, 10000);
  static const double overflowHeight = 745;
  static final Settings settings = Settings(
    dictionaryResponseType: DictionaryResponseType.short.title(),
    translationChoice: TranslationChoices.translate.title(),
    numberOfSynonyms: 10,
    numberOfAntonyms: 10,
    readingFontSize: 16,
    numberOfEssentialLeft: 1848,
    language: 'System default',
    dictionaryResponseSelectedListVietnamese: 'Phiên âm, Định nghĩa, Ví dụ',
    dictionaryResponseSelectedListEnglish: 'Pronunciation, Definition, Example',
    readingFontSizeSliderValue: 0.2,
    windowsWidth: 400,
    windowsHeight: 700,
    themeMode: 'ThemeMode.system',
    openAppCount: 0,
    themeColor: Colors.blue.value,
    enableAdaptiveTheme: true,
    translationLanguageTarget: 'autoDetect',
  );
}