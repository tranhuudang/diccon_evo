import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class Properties {
  // Ensures end-users cannot initialize the class
  Properties._();
  static final Properties _instance = Properties._();
  static Properties get instance => _instance;

  static Future<void> initialize() async {
    instance.settings = await instance._getSettings();
  }

  Future<void> saveSettings(Settings newSettings) async {
    await instance._saveSettings(newSettings);
    // Reload setting after saving new value;
    settings = newSettings;
  }

  Settings settings = Settings(
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

  Future<void> _saveSettings(Settings newSetting) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('readingFontSize', newSetting.readingFontSize);
    await prefs.setString(
        'dictionaryResponseType', newSetting.dictionaryResponseType);
    await prefs.setString('translationChoice', newSetting.translationChoice);
    await prefs.setDouble(
        'readingFontSizeSliderValue', newSetting.readingFontSizeSliderValue);
    await prefs.setInt('numberOfSynonyms', newSetting.numberOfSynonyms);
    await prefs.setInt('numberOfAntonyms', newSetting.numberOfAntonyms);
    await prefs.setInt('openAppCount', newSetting.openAppCount);
    await prefs.setString('language', newSetting.language);
    await prefs.setString(
        'translationLanguageTarget', newSetting.translationLanguageTarget);
    await prefs.setString('dictionaryResponseSelectedListEnglish',
        newSetting.dictionaryResponseSelectedListEnglish);
    await prefs.setString('dictionaryResponseSelectedListVietnamese',
        newSetting.dictionaryResponseSelectedListVietnamese);
    await prefs.setInt('essentialLeft', newSetting.numberOfEssentialLeft);
    await prefs.setDouble('widthOfWindowSize', newSetting.windowsWidth);
    await prefs.setDouble('heightOfWindowSize', newSetting.windowsHeight);
    await prefs.setString('themeMode', newSetting.themeMode);
    await prefs.setInt('themeColor', newSetting.themeColor);
    await prefs.setBool('enableAdaptiveTheme', newSetting.enableAdaptiveTheme);
    if (kDebugMode) {
      print("Setting saved");
    }
  }

  Future<Settings> _getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    var savedSetting = settings.copyWith(
      readingFontSize:
          prefs.getDouble('readingFontSize') ?? settings.readingFontSize,
      translationChoice: prefs.getString('translationChoice') ??
          settings.translationChoice,
      openAppCount:
          prefs.getInt("openAppCount") ?? settings.openAppCount,
      dictionaryResponseType: prefs.getString('dictionaryResponseType') ??
          settings.dictionaryResponseType,
      translationLanguageTarget: prefs.getString('translationLanguageTarget') ??
          settings.translationLanguageTarget,
      readingFontSizeSliderValue:
          prefs.getDouble('readingFontSizeSliderValue') ??
              settings.readingFontSizeSliderValue,
      numberOfSynonyms:
          prefs.getInt('numberOfSynonyms') ?? settings.numberOfSynonyms,
      numberOfAntonyms:
          prefs.getInt('numberOfAntonyms') ?? settings.numberOfAntonyms,
      language: prefs.getString('language') ?? settings.language,
      dictionaryResponseSelectedListVietnamese:
          prefs.getString('dictionaryResponseSelectedListVietnamese') ??
              settings.dictionaryResponseSelectedListVietnamese,
      dictionaryResponseSelectedListEnglish:
          prefs.getString('dictionaryResponseSelectedListEnglish') ??
              settings.dictionaryResponseSelectedListEnglish,
      numberOfEssentialLeft: prefs.getInt('essentialLeft') ??
          settings.numberOfEssentialLeft,
      windowsWidth:
          prefs.getDouble("widthOfWindowSize") ?? settings.windowsWidth,
      windowsHeight: prefs.getDouble("heightOfWindowSize") ??
          settings.windowsHeight,
      themeMode: prefs.getString("themeMode") ?? settings.themeMode,
      themeColor: prefs.getInt("themeColor") ?? settings.themeColor,
      enableAdaptiveTheme: prefs.getBool("enableAdaptiveTheme") ??
          settings.enableAdaptiveTheme,
    );
    if (kDebugMode) {
      print("New setting is saved with these bellow customs:");
      print("numberOfSynonyms: ${settings.numberOfSynonyms}");
      print("numberOfAntonyms: ${settings.numberOfAntonyms}");
      print("numberOfEssentialLeft: ${settings.numberOfEssentialLeft}");
      print("readingFontSize: ${settings.readingFontSize}");
      print(
          "readingFontSizeSliderValue: ${settings.readingFontSizeSliderValue}");
      print("language: ${settings.language}");
      print(
          "dictionaryResponseSelectedListVietnamese: ${settings.dictionaryResponseSelectedListVietnamese}");
      print(
          "dictionaryResponseSelectedListEnglish: ${settings.dictionaryResponseSelectedListEnglish}");
      print("windowsWidth: ${settings.windowsWidth}");
      print("windowsHeight: ${settings.windowsHeight}");
      print("themeMode: ${settings.themeMode}");
      print("language: ${settings.language}");
      print("themeColor: ${settings.themeColor}");
    }
    return savedSetting;
  }
}
