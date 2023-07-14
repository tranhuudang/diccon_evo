import 'dart:async';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:diccon_evo/services/data_service.dart';
import 'package:diccon_evo/services/thesaurus_service.dart';
import 'package:diccon_evo/views/article_history.dart';
import 'package:diccon_evo/views/article_list.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/word_history.dart';
import 'package:diccon_evo/views/settings.dart';
import 'package:diccon_evo/views/writing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/article.dart';
import 'models/word.dart';
import 'package:flutter/material.dart';

/// This enum should always be matched with Global.pages in the order of values
/// As in this app, the order/index is used to detect what view to open.
enum AppViews {
  dictionaryView,
  articleListView,
  writingView,
  settingsView,
  historyView,
  articleHistoryView
}

class Level {
  static String beginner = "beginner",
      elementary = "elementary",
      intermediate = "intermediate",
      advanced = "advanced";
}

class Global {


  static late DataService dataService;
  static late ThesaurusService thesaurusService;

  static List<Word> wordList = [];
  static List<Article> defaultArticleList = [];
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

  // Theme for custom title button on Windows
  static final buttonColors = WindowButtonColors(
      iconNormal: Colors.black,
      mouseOver: Colors.grey.shade100,
      mouseDown: Colors.grey.shade200,
      iconMouseOver: Colors.black,
      iconMouseDown: Colors.black);

  static final closeButtonColors = WindowButtonColors(
      mouseOver: const Color(0xFFD32F2F),
      mouseDown: const Color(0xFFB71C1C),
      iconNormal: Colors.black,
      iconMouseOver: Colors.white);


  static List<Widget> pages = [
    DictionaryView(),
    ArticleListView(),
    WritingView(),
    SettingsView(),
    HistoryView(),
    ArticleListHistoryView()
  ];

  static PageController pageController = PageController();

  static const String DICCON = "Diccon";
  static const String DICCON_DICTIONARY = "Diccon Evo";
  static const String DICTIONARY = "Dictionary";
  static const String HISTORY = "History";
  static const String ARTICLE_LIST = "Articles";
  static const String EV_DATA_PATH = 'assets/dictionary/diccon_ev.txt';
  static const String VE_DATA_PATH = 'assets/dictionary/diccon_ve.txt';
  static const String BLANK_SPACE = ' ';
  static const String HISTORY_FILENAME = 'history.json';
  static const String ARTICLE_HISTORY_FILENAME = 'article_history.json';
  static const String EN_SYNONYMS_PATH = 'assets/thesaurus/english_synonyms.json';
  static const String EN_ANTONYMS_PATH = 'assets/thesaurus/english_antonyms.json';

  static void saveSettings(double newReadingFontSize,
      double newReadingFontSizeSliderValue, int newNumberOfSynonyms, int newNumberOfAntonyms) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('readingFontSize', newReadingFontSize);
    await prefs.setDouble(
        'readingFontSizeSliderValue', newReadingFontSizeSliderValue);
    await prefs.setInt('numberOfSynonyms', newNumberOfSynonyms);
    await prefs.setInt('numberOfAntonyms', newNumberOfAntonyms);
  }

  static Future<bool> getSettings() async {
    Completer complete = Completer();
    var prefs = await SharedPreferences.getInstance();
    complete.complete(prefs);
    defaultReadingFontSize = prefs.getDouble('readingFontSize') ?? defaultReadingFontSize;
    defaultReadingFontSizeSliderValue =
        prefs.getDouble('readingFontSizeSliderValue') ??
            defaultReadingFontSizeSliderValue;
    defaultNumberOfSynonyms = prefs.getInt('numberOfSynonyms') ?? defaultNumberOfSynonyms;
    defaultNumberOfAntonyms = prefs.getInt('numberOfAntonyms') ?? defaultNumberOfAntonyms;
    return true;
  }
}
