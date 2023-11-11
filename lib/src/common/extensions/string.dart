import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

extension StringExtenstion on String {
  DictionaryResponseType toDictionaryResponseType() {
    switch (this) {
      case "shortWithOutPronunciation":
        return DictionaryResponseType.shortWithOutPronunciation;
      case "short":
        return DictionaryResponseType.short;
      case "normal":
        return DictionaryResponseType.normal;
      case "normalWithOutExample":
        return DictionaryResponseType.normalWithOutExample;
      case "normalWithOutPronunciation":
        return DictionaryResponseType.normalWithOutPronunciation;
      default:
        throw FormatException(
            "$this is not have a valid value to convert to DictionaryResponseType");
    }
  }

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
