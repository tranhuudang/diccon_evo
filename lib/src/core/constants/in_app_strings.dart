import 'package:diccon_evo/src/core/core.dart';

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
      "Pretend you are an expert language teacher named Mr.Diccon who know everything, especially English and Vietnamese.";
  static const languageExpertTranslatorRole =
      "Pretend you are an expert language translator";
  static String getViToEnSingleBasicWordTranslateQuestion(String word) {
    return 'Translate the Vietnamese word "[${word.trim()}]" to English and provide the response in the exact following format:'
        ''
        'Pronunciation: /[pronunciation in Vietnamese]/'
        'Definition: '
        ' '
        '[different definitions in English]'
        'Example:'
        ''
        '1.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '2.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '3.  [Example sentence in Vietnamese] ([Example sentence in English])';
  }
  static String getViToEnSingleSpecializedWordTranslateQuestion(String word) {
    String topic = Properties.instance.settings.dictionarySpecializedVietnamese;
    return 'Translate the Vietnamese word "[${word.trim()}]" to English and provide the response in the exact following format:'
        ''
        'Definition: '
        ' '
        '[definition in ${topic.i18nEnglish}] context in English]'
        'Example:'
        ''
        '1.  [Example sentence in ${topic.i18nEnglish} in Vietnamese] ([Example sentence in English])'
        '2.  [Example sentence in ${topic.i18nEnglish} in Vietnamese] ([Example sentence in English])'
        '3.  [Example sentence in ${topic.i18nEnglish} in Vietnamese] ([Example sentence in English])';
  }

  static String getViToEnParagraphTranslateQuestion(String word) {
    return 'Help me translate this paragraph to English: $word';
  }

  static String getEnToViSingleBasicWordTranslateQuestion(String word) {
    return 'Translate the English word "[${word.trim()}]" to Vietnamese and provide the response in the exact following format:'
        ''
        'Phiên âm: /[pronunciation in English]/'
        'Định nghĩa: '
        ''
        '[different definitions in Vietnamese]'
        'Ví dụ:'
        ''
        '1.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '2.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '3.  [Example sentence in English] ([Example sentence in Vietnamese])';
  }

  static String getEnToViSingleSpecializedWordTranslateQuestion(String word) {
    String topic = Properties.instance.settings.dictionarySpecializedVietnamese;
    return 'Translate the English word "[${word.trim()}]" to Vietnamese and provide the response in the exact following format:'
        ''
        'Định nghĩa: '
        ''
        '[meaning of the word "[${word.trim()}]" in ${topic.i18nEnglish}] environment in Vietnamese]'
        'Ví dụ:'
        ''
        '1.  [Example sentence in ${topic.i18nEnglish} in English] ([Example sentence in Vietnamese])'
        '2.  [Example sentence in ${topic.i18nEnglish} in English] ([Example sentence in Vietnamese])';
  }

  static String getEnToViParagraphTranslateQuestion(String word) {
    return 'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: $word';
  }
}
