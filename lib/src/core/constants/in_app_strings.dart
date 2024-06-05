import 'package:diccon_evo/src/core/core.dart';

import '../configs/configs.dart';

class InAppStrings {
  static const String blankSpace = ' ';
  static const String splitCharacter = ", ";
  static const List<String> list3000EssentialTopic = [
    "School-supplies",
    "Actions",
    "Everyday activities",
    "Sea",
    "The number",
    "Shopping",
    "Bedroom",
    "Friendship",
    "Kitchen",
    "Jewelry",
    "Environment",
    "Living room",
    "Hospital",
    "Computer",
    "Housework",
    "The shops",
    "Entertainment",
    "Traveling",
    "Hometown",
    "Mid-autumn",
    "Wedding",
    "Airport",
    "Health",
    "Vegetable",
    "Transport",
    "Time",
    "Emotions",
    "Character",
    "Drinks",
    "Flowers",
    "Movies",
    "Soccer",
    "Christmas",
    "Foods",
    "Sport",
    "Music",
    "Love",
    "Restaurant-Hotel",
    "School",
    "Colors",
    "Weather",
    "Clothes",
    "Body parts",
    "Education",
    "Family",
    "Fruits",
    "Animal",
    "Insect",
    "Study",
    "Plants",
    "Country",
    "Seafood",
    "Energy",
    "Jobs",
    "Diet",
    "Natural disaster",
    "Asking the way",
    "A hotel room",
    "At the post office",
    "At the bank"
  ];
  static const languageTeacherRole =
      "Pretend you are an expert language teacher named Mr.Diccon who know nothing but languages.";
  static const languageExpertTranslatorRole =
      "Pretend you are an expert language translator";
  static String getViToEnSingleWordTranslateQuestion(String word) {
    final listTopic1 = Properties
        .instance.settings.dictionaryResponseSelectedListVietnamese
        .replaceAll(DefaultSettings.dictionaryResponseVietnameseConstant, '');
    final listTopic2 = listTopic1.replaceAll(
        DefaultSettings.dictionaryResponseEnglishConstant, '');
    var listString = '';
    if (listTopic2.trim().replaceAll(',', '').length > 2) {
      listTopic2.split(',').forEach((word) {
        if (word.length > 2) {
          listString += ''
              '  ● ${word.trim()}'
              ''
              '  Definition: [definition in ${word.trim().i18nEnglish}] context in English]'
              '  Example:'
              ''
              '1.  [Example sentence in ${word.trim().i18nEnglish} in Vietnamese] ([Example sentence in English])'
              '2.  [Example sentence in ${word.trim().i18nEnglish} in Vietnamese] ([Example sentence in English])';
        }
      });
    }
    return '  Translate the Vietnamese word "[${word.trim()}]" to English and provide the response in the following format:'
        ''
        '  Phonetics: /[phonetic transcription]/'
        '  Definition: [definition in English]'
        '  Example:'
        ''
        '1.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '2.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '3.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '4.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '5.  [Example sentence in Vietnamese] ([Example sentence in English])'
        ''
        '$listString';
  }

  static String getViToEnParagraphTranslateQuestion(String word) {
    return 'Help me translate this paragraph to English: $word';
  }

  static String getEnToViSingleWordTranslateQuestion(String word) {
    final listTopic1 = Properties
        .instance.settings.dictionaryResponseSelectedListVietnamese
        .replaceAll(DefaultSettings.dictionaryResponseVietnameseConstant, '');
    final listTopic2 = listTopic1.replaceAll(
        DefaultSettings.dictionaryResponseEnglishConstant, '');
    var listString = '';
    if (listTopic2.trim().replaceAll(',', '').length > 2) {
      listTopic2.split(',').forEach((word) {
        if (word.length > 2) {
          listString += ''
              '  ● ${word.trim()}'
              ''
              '  Định nghĩa: [definition in ${word.trim().i18nEnglish}] context in Vietnamese]'
              '  Ví dụ:'
              ''
              '1.  [Example sentence in ${word.trim().i18nEnglish} in English] ([Example sentence in Vietnamese])'
              '2.  [Example sentence in ${word.trim().i18nEnglish} in English] ([Example sentence in Vietnamese])';
        }
      });
    }
    return '  Translate the English word "[${word.trim()}]" to Vietnamese and provide the response in the following format:'
        ''
        '  Phiên âm: /[phonetic transcription]/'
        '  Định nghĩa: [definition in Vietnamese]'
        '  Ví dụ:'
        ''
        '1.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '2.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '3.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '4.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '5.  [Example sentence in English] ([Example sentence in Vietnamese])'
        ''
        '$listString';
  }

  static String getEnToViParagraphTranslateQuestion(String word) {
    return 'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: $word';
  }
}
