import 'package:flutter/material.dart';
import '../../core/core.dart';

extension StringExtenstion on String {
  Locale toLocale() {
    switch (this) {
      case "English":
        return const Locale('en', "US");
      case "Tiếng Việt":
        return const Locale('vi', "VI");
      case "System default":
        return WidgetsBinding.instance.platformDispatcher.locale;
      default:
        return WidgetsBinding.instance.platformDispatcher.locale;
    }
  }

  TranslationLanguageTarget toTranslationLanguageTarget() {
    switch (this) {
      case 'autoDetect':
        return TranslationLanguageTarget.autoDetect;
      case 'vietnameseToEnglish':
        return TranslationLanguageTarget.vietnameseToEnglish;
      case 'englishToVietnamese':
        return TranslationLanguageTarget.englishToVietnamese;
      default:
        throw FormatException(
            "$this is not have a valid value to convert to TranslationLanguageTarget");
    }
  }

  TranslationChoices toTranslationChoice() {
    switch (this) {
      case "Classic":
        return TranslationChoices.translate;
      case "AI":
        return TranslationChoices.explain;
      default:
        throw FormatException(
            "$this is not have a valid value to convert to TranslationChoice");
    }
  }

  int numberOfWord() {
    if (isEmpty) return 0;
    // Split the sentence into words using whitespace as the delimiter
    List<String> words = split(' ');
    // Remove any leading or trailing whitespaces from each word
    words = words.map((word) => word.trim()).toList();
    // Remove any empty words (resulting from multiple spaces)
    words = words.where((word) => word.isNotEmpty).toList();
    // Return the count of words
    return words.length;
  }

  String removeSpecialCharacters() {
    RegExp regExp = RegExp(r"[^\p{L}\p{N}']+", unicode: true);
    var output = replaceAll('\'', '');
    output = output.replaceAll(regExp, "");
    return output;
  }

  String upperCaseFirstLetter() {
    var output =
        "${substring(0, 1).toUpperCase()}${substring(1).toLowerCase()}";
    return output;
  }

  /// Get the first letter in a Word
  String getFirstLetter() {
    return substring(0, 1);
  }

  int numberOfLine() {
    return split('\n').length;
  }
}
