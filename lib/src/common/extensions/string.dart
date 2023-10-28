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
