import 'package:flutter/material.dart';

class PropertiesConstants{
  static String version = "v309";

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
  static const String privacyPolicyURL = 'https://www.privacypolicies.com/live/71b9bdfa-e762-479e-94d2-340ba3406128';
}