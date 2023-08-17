import 'dart:async';
//import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:diccon_evo/services/data_service.dart';
import 'package:diccon_evo/services/thesaurus_service.dart';
import 'package:diccon_evo/views/article_list.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/settings.dart';
import 'package:diccon_evo/views/video_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/article.dart';
import 'models/video.dart';
import 'models/word.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/models/user_info.dart';

/// This enum should always be matched with Global.pages in the order of values
/// As in this app, the order/index is used to detect what view to open.
enum AppViews { dictionaryView, articleListView, videoListView, settingsView }

class Level {
  static String beginner = "beginner",
      elementary = "elementary",
      intermediate = "intermediate",
      advanced = "advanced";
}

class Properties {
  static UserInfo userInfo = UserInfo("", "", "", "");

  static late DataService dataService;
  static late ThesaurusService thesaurusService;

  static List<Word> wordList = [];
  static List<Article> defaultArticleList = [];
  static List<Video> defaultVideoList = [];

  // Thesaurus
  static Map<String, List<String>> synonymsData = {};
  static Map<String, List<String>> antonymsData = {};
  static int defaultNumberOfSynonyms = 10;
  static int defaultNumberOfAntonyms = 10;

  // All view in application
  static double defaultReadingFontSizeSliderValue = 0.2;
  static double defaultReadingFontSize = 16;
  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  // Windows size
  static bool isLargeWindows = false;

  static List<Widget> pages = const [
    DictionaryView(),
    ArticleListView(),
    VideoListView(),
    SettingsView()
  ];

  /// Manually change this version base on commit count
  static String version = "v93";
  static PageController pageController = PageController();

  static const double minWidth = 400;
  static const double minHeight = 600;
  static double defaultWindowHeight = 700;
  static double defaultWindowWidth = 600;
  static double titleTileFontSize = 14.0;
  static bool isDarkMode = false;
  static const String diccon = "Diccon";
  static  String dictionary = "Dictionary";
  static  String history = "History";
  static  String articleList = "Articles";
  static const String evDataPath = 'assets/dictionary/diccon_ev.txt';
  static const String veDataPath = 'assets/dictionary/diccon_ve.txt';
  static const String blankSpace = ' ';
  static const String wordHistoryFileName = 'history.json';
  static const String articleHistoryFileName = 'article_history.json';
  static const String videoHistoryFileName = 'video_history.json';
  static const String enSynonymsPath =
      'assets/thesaurus/english_synonyms.json';
  static const String enAntonymsPath =
      'assets/thesaurus/english_antonyms.json';

  static const List<String> welcomeBackgrounds = [
    "assets/welcome/42e1de5e-994c-4ee2-813d-448be978b9ba.jpg",
    "assets/welcome/aafb0a26-16d3-41eb-87a7-540deb4b61ce.jpg",
    "assets/welcome/ba5f8c3a-b107-419c-8f8b-a2002cd8c299.jpg",
    "assets/welcome/f8b5b134-03a8-444d-90d2-05a8fb2f0ba6.jpg"
  ];

  static void saveSettings(
      double? newReadingFontSize,
      double? newReadingFontSizeSliderValue,
      int? newNumberOfSynonyms,
      int? newNumberOfAntonyms) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(
        'readingFontSize', newReadingFontSize ?? defaultReadingFontSize);
    await prefs.setDouble('readingFontSizeSliderValue',
        newReadingFontSizeSliderValue ?? defaultReadingFontSizeSliderValue);
    await prefs.setInt(
        'numberOfSynonyms', newNumberOfSynonyms ?? defaultNumberOfSynonyms);
    await prefs.setInt(
        'numberOfAntonyms', newNumberOfAntonyms ?? defaultNumberOfAntonyms);
    await prefs.setDouble('widthOfWindowSize', defaultWindowWidth);
    await prefs.setDouble('heightOfWindowSize', defaultWindowHeight);
  }

  static Future<bool> getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    defaultReadingFontSize =
        prefs.getDouble('readingFontSize') ?? defaultReadingFontSize;
    defaultReadingFontSizeSliderValue =
        prefs.getDouble('readingFontSizeSliderValue') ??
            defaultReadingFontSizeSliderValue;
    defaultNumberOfSynonyms =
        prefs.getInt('numberOfSynonyms') ?? defaultNumberOfSynonyms;
    defaultNumberOfAntonyms =
        prefs.getInt('numberOfAntonyms') ?? defaultNumberOfAntonyms;
    defaultWindowWidth= prefs.getDouble("widthOfWindowSize") ?? defaultWindowWidth;
    defaultWindowHeight = prefs.getDouble("heightOfWindowSize") ?? defaultWindowHeight;
    return true;
  }
}