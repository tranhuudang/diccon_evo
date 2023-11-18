import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  Settings settings = DefaultSettings.settings;

  Future<void> _saveSettings(Settings newSetting) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        SharedPreferencesKey.readingFontSize, newSetting.readingFontSize);
    await prefs.setString(SharedPreferencesKey.dictionaryResponseType,
        newSetting.dictionaryResponseType);
    await prefs.setString(
        SharedPreferencesKey.translationChoice, newSetting.translationChoice);
    await prefs.setDouble(SharedPreferencesKey.readingFontSizeSliderValue,
        newSetting.readingFontSizeSliderValue);
    await prefs.setInt(
        SharedPreferencesKey.numberOfSynonyms, newSetting.numberOfSynonyms);
    await prefs.setInt(
        SharedPreferencesKey.numberOfAntonyms, newSetting.numberOfAntonyms);
    await prefs.setInt(
        SharedPreferencesKey.openAppCount, newSetting.openAppCount);
    await prefs.setString(SharedPreferencesKey.language, newSetting.language);
    await prefs.setString(SharedPreferencesKey.translationLanguageTarget,
        newSetting.translationLanguageTarget);
    await prefs.setString(
        SharedPreferencesKey.dictionaryResponseSelectedListEnglish,
        newSetting.dictionaryResponseSelectedListEnglish);
    await prefs.setString(
        SharedPreferencesKey.dictionaryResponseSelectedListVietnamese,
        newSetting.dictionaryResponseSelectedListVietnamese);
    await prefs.setInt(
        SharedPreferencesKey.essentialLeft, newSetting.numberOfEssentialLeft);
    await prefs.setDouble(
        SharedPreferencesKey.widthOfWindowSize, newSetting.windowsWidth);
    await prefs.setDouble(
        SharedPreferencesKey.heightOfWindowSize, newSetting.windowsHeight);
    await prefs.setString(SharedPreferencesKey.themeMode, newSetting.themeMode);
    await prefs.setInt(SharedPreferencesKey.themeColor, newSetting.themeColor);
    await prefs.setBool(SharedPreferencesKey.enableAdaptiveTheme,
        newSetting.enableAdaptiveTheme);
    if (kDebugMode) {
      print("Setting saved");
    }
  }

  Future<Settings> _getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    var savedSetting = settings.copyWith(
      readingFontSize: prefs.getDouble(SharedPreferencesKey.readingFontSize) ??
          settings.readingFontSize,
      translationChoice:
          prefs.getString(SharedPreferencesKey.translationChoice) ??
              settings.translationChoice,
      openAppCount: prefs.getInt(SharedPreferencesKey.openAppCount) ??
          settings.openAppCount,
      dictionaryResponseType:
          prefs.getString(SharedPreferencesKey.dictionaryResponseType) ??
              settings.dictionaryResponseType,
      translationLanguageTarget:
          prefs.getString(SharedPreferencesKey.translationLanguageTarget) ??
              settings.translationLanguageTarget,
      readingFontSizeSliderValue:
          prefs.getDouble(SharedPreferencesKey.readingFontSizeSliderValue) ??
              settings.readingFontSizeSliderValue,
      numberOfSynonyms: prefs.getInt(SharedPreferencesKey.numberOfSynonyms) ??
          settings.numberOfSynonyms,
      numberOfAntonyms: prefs.getInt(SharedPreferencesKey.numberOfAntonyms) ??
          settings.numberOfAntonyms,
      language:
          prefs.getString(SharedPreferencesKey.language) ?? settings.language,
      dictionaryResponseSelectedListVietnamese: prefs.getString(
              SharedPreferencesKey.dictionaryResponseSelectedListVietnamese) ??
          settings.dictionaryResponseSelectedListVietnamese,
      dictionaryResponseSelectedListEnglish: prefs.getString(
              SharedPreferencesKey.dictionaryResponseSelectedListEnglish) ??
          settings.dictionaryResponseSelectedListEnglish,
      numberOfEssentialLeft: prefs.getInt(SharedPreferencesKey.essentialLeft) ??
          settings.numberOfEssentialLeft,
      windowsWidth: prefs.getDouble(SharedPreferencesKey.widthOfWindowSize) ??
          settings.windowsWidth,
      windowsHeight: prefs.getDouble(SharedPreferencesKey.heightOfWindowSize) ??
          settings.windowsHeight,
      themeMode:
          prefs.getString(SharedPreferencesKey.themeMode) ?? settings.themeMode,
      themeColor:
          prefs.getInt(SharedPreferencesKey.themeColor) ?? settings.themeColor,
      enableAdaptiveTheme:
          prefs.getBool(SharedPreferencesKey.enableAdaptiveTheme) ??
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
