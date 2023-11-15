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
    instance._defaultSetting = await instance._getSettings();
  }

  Future<void> saveSettings(Settings settings) async {
    instance._saveSettings(settings);
  }

  Settings get settings {
    return instance._defaultSetting;
  }

  set settings(Settings settings) {
    instance._defaultSetting = settings;
  }

  /// Manually change this version base on commit count

  static UserInfo userInfo = UserInfo.empty();

  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  // All view in application
  Settings _defaultSetting = Settings(
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
    var savedSetting = _defaultSetting.copyWith(
      readingFontSize:
          prefs.getDouble('readingFontSize') ?? _defaultSetting.readingFontSize,
      translationChoice: prefs.getString('translationChoice') ??
          _defaultSetting.translationChoice,
      openAppCount:
          prefs.getInt("openAppCount") ?? _defaultSetting.openAppCount,
      dictionaryResponseType: prefs.getString('dictionaryResponseType') ??
          _defaultSetting.dictionaryResponseType,
      translationLanguageTarget: prefs.getString('translationLanguageTarget') ??
          _defaultSetting.translationLanguageTarget,
      readingFontSizeSliderValue:
          prefs.getDouble('readingFontSizeSliderValue') ??
              _defaultSetting.readingFontSizeSliderValue,
      numberOfSynonyms:
          prefs.getInt('numberOfSynonyms') ?? _defaultSetting.numberOfSynonyms,
      numberOfAntonyms:
          prefs.getInt('numberOfAntonyms') ?? _defaultSetting.numberOfAntonyms,
      language: prefs.getString('language') ?? _defaultSetting.language,
      dictionaryResponseSelectedListVietnamese:
          prefs.getString('dictionaryResponseSelectedListVietnamese') ??
              _defaultSetting.dictionaryResponseSelectedListVietnamese,
      dictionaryResponseSelectedListEnglish:
          prefs.getString('dictionaryResponseSelectedListEnglish') ??
              _defaultSetting.dictionaryResponseSelectedListEnglish,
      numberOfEssentialLeft: prefs.getInt('essentialLeft') ??
          _defaultSetting.numberOfEssentialLeft,
      windowsWidth:
          prefs.getDouble("widthOfWindowSize") ?? _defaultSetting.windowsWidth,
      windowsHeight: prefs.getDouble("heightOfWindowSize") ??
          _defaultSetting.windowsHeight,
      themeMode: prefs.getString("themeMode") ?? _defaultSetting.themeMode,
      themeColor: prefs.getInt("themeColor") ?? _defaultSetting.themeColor,
      enableAdaptiveTheme: prefs.getBool("enableAdaptiveTheme") ??
          _defaultSetting.enableAdaptiveTheme,
    );
    if (kDebugMode) {
      print("New setting is saved with these bellow customs:");
      print("numberOfSynonyms: ${_defaultSetting.numberOfSynonyms}");
      print("numberOfAntonyms: ${_defaultSetting.numberOfAntonyms}");
      print("numberOfEssentialLeft: ${_defaultSetting.numberOfEssentialLeft}");
      print("readingFontSize: ${_defaultSetting.readingFontSize}");
      print(
          "readingFontSizeSliderValue: ${_defaultSetting.readingFontSizeSliderValue}");
      print("language: ${_defaultSetting.language}");
      print(
          "dictionaryResponseSelectedListVietnamese: ${_defaultSetting.dictionaryResponseSelectedListVietnamese}");
      print(
          "dictionaryResponseSelectedListEnglish: ${_defaultSetting.dictionaryResponseSelectedListEnglish}");
      print("windowsWidth: ${_defaultSetting.windowsWidth}");
      print("windowsHeight: ${_defaultSetting.windowsHeight}");
      print("themeMode: ${_defaultSetting.themeMode}");
      print("language: ${_defaultSetting.language}");
      print("themeColor: ${_defaultSetting.themeColor}");
    }
    return savedSetting;
  }
}
