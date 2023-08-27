import 'dart:async';
import 'package:diccon_evo/screens/dictionary/ui/dictionary.dart';
import 'package:diccon_evo/screens/setting/ui/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/word.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/models/user_info.dart';

/// This enum should always be matched with Global.pages in the order of values
/// As in this app, the order/index is used to detect what view to open.
enum AppViews { dictionaryView, settingsView }

class Level {
  static String beginner = "beginner",
      elementary = "elementary",
      intermediate = "intermediate",
      advanced = "advanced";
}

class Properties {
  static UserInfo userInfo = UserInfo("", "", "", "");

  static List<Word> wordList = [];
  static List<String> suggestionListWord = [];

  // Thesaurus
  static Map<String, List<String>> synonymsData = {};
  static Map<String, List<String>> antonymsData = {};
  static int defaultNumberOfSynonyms = 10;
  static int defaultNumberOfAntonyms = 10;

  // Focus of this textField cause a lot of trouble as the keyboard keep open up
  // when focus still in the textField, so we move it here to make it static to
  // control focus
  static FocusNode textFieldFocusNode = FocusNode();

  // Windows size
  static bool isLargeWindows = false;

  static List<Widget> pages = const [DictionaryView(), SettingsView()];

  /// Manually change this version base on commit count
  static String version = "v126";
  static PageController pageController = PageController();

  static const double minWidth = 400;
  static const double minHeight = 600;
  static double defaultWindowHeight = 700;
  static double defaultWindowWidth = 600;
  static double titleTileFontSize = 14.0;
  static bool isDarkMode = false;
  static const String diccon = "Diccon";
  static const String evDataPath = 'assets/dictionary/diccon_ev.txt';
  static const String veDataPath = 'assets/dictionary/diccon_ve.txt';
  static const String blankSpace = ' ';
  static const String wordHistoryFileName = 'history.json';
  static const String enSynonymsPath = 'assets/thesaurus/english_synonyms.json';
  static const String enAntonymsPath = 'assets/thesaurus/english_antonyms.json';

  static void saveSettings(
      int? newNumberOfSynonyms,
      int? newNumberOfAntonyms) async {
    var prefs = await SharedPreferences.getInstance();
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
    defaultNumberOfSynonyms =
        prefs.getInt('numberOfSynonyms') ?? defaultNumberOfSynonyms;
    defaultNumberOfAntonyms =
        prefs.getInt('numberOfAntonyms') ?? defaultNumberOfAntonyms;
    defaultWindowWidth =
        prefs.getDouble("widthOfWindowSize") ?? defaultWindowWidth;
    defaultWindowHeight =
        prefs.getDouble("heightOfWindowSize") ?? defaultWindowHeight;
    return true;
  }
}
