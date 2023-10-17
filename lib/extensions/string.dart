import 'dart:ui';

import '../data/models/dictionary_response_type.dart';
import '../data/models/translation_choices.dart';

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
      default:
        throw FormatException(
            "$this is not have a valid value to convert to Locale");
    }
  }


  TranslationChoices toTranslationChoice() {
    switch (this) {
      case "Classic":
        return TranslationChoices.classic;
      case "AI":
        return TranslationChoices.ai;
      default:
        throw FormatException(
            "$this is not have a valid value to convert to TranslationChoice");
    }
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

  /// Get the first word in a String
  String getFirstWord() {
    return substring(0, !contains(" ") ? length : indexOf(" "));
  }

  /// Get the first letter in a Word
  String getFirstLetter() {
    return substring(0, 1);
  }

  int numberOfLine() {
    return split('\n').length;
  }
}
