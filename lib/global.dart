import 'package:diccon_evo/views/article_list.dart';
import 'package:diccon_evo/views/dictionary.dart';
import 'package:diccon_evo/views/history.dart';
import 'package:diccon_evo/views/settings.dart';
import 'package:diccon_evo/views/writing.dart';

import 'models/word.dart';
import 'package:flutter/material.dart';

/// This enum should always be matched with Global.pages in the order of values
/// As in this app, the order/index is used to detect what view to open.
enum AppViews {
  articleListView,
  writingView,
  settingsView,
  historyView,
  dictionaryView,
}

class Global {
  static List<Word> wordList = [];
  // All view in application
  static List<Widget> pages =  [
    ArticleListView(),
    WritingView(),
    SettingsView(),
    HistoryView(),
    DictionaryView(),
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
}
