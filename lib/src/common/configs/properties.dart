import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/setting.dart';
import '../data/models/user_info.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class Properties {
  /// Manually change this version base on commit count

  static UserInfo userInfo = UserInfo.empty();

  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  // All view in application
  static Setting defaultSetting = Setting(
    dictionaryResponseType: DictionaryResponseType.short.title(),
    translationChoice: TranslationChoices.classic.title(),
    numberOfSynonyms: 10,
    numberOfAntonyms: 10,
    readingFontSize: 16,
    numberOfEssentialLeft: 1848,
    language: 'System default',
    dictionaryResponseSelectedList: 'Phiên âm, Định nghĩa, Ví dụ',
    readingFontSizeSliderValue: 0.2,
    windowsWidth: 400,
    windowsHeight: 700,
    themeMode: 'ThemeMode.system',
    openAppCount: 0,
    themeColor: Colors.blue.value,
    enableAdaptiveTheme: true,
  );

  static void saveSettings(Setting newSetting) async {
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
    await prefs.setString('dictionaryResponseSelectedList',
        newSetting.dictionaryResponseSelectedList);
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

  static Future<bool> getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    defaultSetting = defaultSetting.copyWith(
      readingFontSize:
          prefs.getDouble('readingFontSize') ?? defaultSetting.readingFontSize,
      translationChoice: prefs.getString('translationChoice') ??
          defaultSetting.translationChoice,
      openAppCount: prefs.getInt("openAppCount") ?? defaultSetting.openAppCount,
      dictionaryResponseType: prefs.getString('dictionaryResponseType') ??
          defaultSetting.dictionaryResponseType,
      readingFontSizeSliderValue:
          prefs.getDouble('readingFontSizeSliderValue') ??
              defaultSetting.readingFontSizeSliderValue,
      numberOfSynonyms:
          prefs.getInt('numberOfSynonyms') ?? defaultSetting.numberOfSynonyms,
      numberOfAntonyms:
          prefs.getInt('numberOfAntonyms') ?? defaultSetting.numberOfAntonyms,
      language: prefs.getString('language') ?? defaultSetting.language,
      dictionaryResponseSelectedList:
          prefs.getString('dictionaryResponseSelectedList') ??
              defaultSetting.dictionaryResponseSelectedList,
      numberOfEssentialLeft:
          prefs.getInt('essentialLeft') ?? defaultSetting.numberOfEssentialLeft,
      windowsWidth:
          prefs.getDouble("widthOfWindowSize") ?? defaultSetting.windowsWidth,
      windowsHeight:
          prefs.getDouble("heightOfWindowSize") ?? defaultSetting.windowsHeight,
      themeMode: prefs.getString("themeMode") ?? defaultSetting.themeMode,
      themeColor: prefs.getInt("themeColor") ?? defaultSetting.themeColor,
      enableAdaptiveTheme: prefs.getBool("enableAdaptiveTheme") ??
          defaultSetting.enableAdaptiveTheme,
    );
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
      print("dictionaryResponseSelectedList: ${Properties.defaultSetting.dictionaryResponseSelectedList}");
      print("windowsWidth: ${Properties.defaultSetting.windowsWidth}");
      print("windowsHeight: ${Properties.defaultSetting.windowsHeight}");
      print("themeMode: ${Properties.defaultSetting.themeMode}");
      print("language: ${Properties.defaultSetting.language}");
      print("themeColor: ${Properties.defaultSetting.themeColor}");
    }
    return true;
  }
}
