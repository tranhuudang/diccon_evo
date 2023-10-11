import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/dictionary_response_type.dart';
import '../data/models/setting.dart';
import '../data/models/translation_choices.dart';
import '../data/models/user_info.dart';
import '../data/models/word.dart';
import 'package:flutter/material.dart';

class Properties {
  /// Manually change this version base on commit count
  static String version = "v293";

  static UserInfo userInfo = UserInfo.empty();

  static List<Word> wordList = [];
  static List<String> suggestionListWord = [];

  // Thesaurus
  static Map<String, List<String>> synonymsData = {};
  static Map<String, List<String>> antonymsData = {};

  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  static const Size minWindowsSize = Size(400, 400);
  static const Size maxWindowsSize = Size(5000, 10000);
  static const double overflowHeight = 745;
  static const String diccon = "Diccon";
  static const String blankSpace = ' ';

  static const String enSynonymsPath = 'assets/thesaurus/english_synonyms.json';
  static const String enAntonymsPath = 'assets/thesaurus/english_antonyms.json';
  static const String evDataPath = 'assets/dictionary/diccon_ev.txt';
  static const String veDataPath = 'assets/dictionary/diccon_ve.txt';

  static const String wordHistoryFileName = 'dictionary_history.json';
  static const String topicHistoryFileName = 'topic_history.json';
  static const String storyHistoryFileName = 'story_history.json';
  static const String storyBookmarkFileName = 'story_bookmark.json';
  static const String essentialFavouriteFileName = 'essential_favourite.json';
  static const String extendStoryFileName = 'extend_story.json';
  // All view in application
  static Setting defaultSetting = Setting(
      dictionaryResponseType: DictionaryResponseType.short.title(),
      translationChoice: TranslationChoices.classic.title(),
      numberOfSynonyms: 10,
      numberOfAntonyms: 10,
      readingFontSize: 16,
      numberOfEssentialLeft: 1848,
      language: 'English',
      readingFontSizeSliderValue: 0.2,
      windowsWidth: 400,
      windowsHeight: 700,
      themeMode: 'ThemeMode.system');

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
    await prefs.setString('language', newSetting.language);
    await prefs.setInt('essentialLeft', newSetting.numberOfEssentialLeft);
    await prefs.setDouble('widthOfWindowSize', newSetting.windowsWidth);
    await prefs.setDouble('heightOfWindowSize', newSetting.windowsHeight);
    await prefs.setString('themeMode', newSetting.themeMode);
    if (kDebugMode) {
      print("Setting saved");
    }
  }

  static Future<bool> getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    defaultSetting = defaultSetting.copyWith(
        readingFontSize: prefs.getDouble('readingFontSize') ??
            defaultSetting.readingFontSize,
        translationChoice: prefs.getString('translationChoice') ??
            defaultSetting.translationChoice,
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
        numberOfEssentialLeft: prefs.getInt('essentialLeft') ??
            defaultSetting.numberOfEssentialLeft,
        windowsWidth:
            prefs.getDouble("widthOfWindowSize") ?? defaultSetting.windowsWidth,
        windowsHeight: prefs.getDouble("heightOfWindowSize") ??
            defaultSetting.windowsHeight,
        themeMode: prefs.getString("themeMode") ?? defaultSetting.themeMode);
    return true;
  }
}
