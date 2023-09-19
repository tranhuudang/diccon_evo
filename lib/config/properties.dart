import 'dart:async';
import 'package:diccon_evo/screens/settings/ui/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';
import '../models/setting.dart';
import '../models/word.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/models/user_info.dart';
import 'package:diccon_evo/screens/home/ui/home.dart';

/// This enum should always be matched with Global.pages in the order of values
/// As in this app, the order/index is used to detect what view to open.
enum AppViews { homeView, settingsView }

class Level {
  static String beginner = "beginner",
      elementary = "elementary",
      intermediate = "intermediate",
      advanced = "advanced";
}

class Properties {
  /// Manually change this version base on commit count
  static String version = "v179";

  static UserInfo userInfo = UserInfo("", "", "", "");

  static List<Word> wordList = [];
  static List<String> suggestionListWord = [];

  // Thesaurus
  static Map<String, List<String>> synonymsData = {};
  static Map<String, List<String>> antonymsData = {};

  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  // Windows size
  static bool isLargeWindows = false;

  static List<Widget> pages = const [HomeView(), SettingsView()];

  static PageController pageController = PageController();

  static const double minWidth = 400;
  static const double minHeight = 600;
  static const double overflowHeight = 710;
  static double titleTileFontSize = 14.0;
  static bool isDarkMode = false;
  static const String diccon = "Diccon";
  static const String evDataPath = 'assets/dictionary/diccon_ev.txt';
  static const String veDataPath = 'assets/dictionary/diccon_ve.txt';
  static const String blankSpace = ' ';

  static const String enSynonymsPath = 'assets/thesaurus/english_synonyms.json';
  static const String enAntonymsPath = 'assets/thesaurus/english_antonyms.json';
  static const String wordHistoryFileName = 'history.json';
  static const String topicHistoryFileName = 'topic_history.json';
  static const String articleHistoryFileName = 'article_history.json';
  static const String articleBookmarkFileName = 'article_bookmark.json';
  static const String essentialFavouriteFileName = 'essential_favourite.json';
  static List<Article> defaultArticleList = [];
  // All view in application
  static Setting defaultSetting = Setting(
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
    await prefs.setDouble(
        'readingFontSizeSliderValue', newSetting.readingFontSizeSliderValue);
    await prefs.setInt('numberOfSynonyms', newSetting.numberOfSynonyms);
    await prefs.setInt('numberOfAntonyms', newSetting.numberOfAntonyms);
    await prefs.setString('language', newSetting.language);
    await prefs.setInt('essentialLeft', newSetting.numberOfEssentialLeft);
    await prefs.setDouble('widthOfWindowSize', newSetting.windowsWidth);
    await prefs.setDouble('heightOfWindowSize', newSetting.windowsHeight);
    await prefs.setString('themeMode', newSetting.themeMode);
  }

  static Future<bool> getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    defaultSetting = defaultSetting.copyWith(
        readingFontSize: prefs.getDouble('readingFontSize') ??
            defaultSetting.readingFontSize,
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
