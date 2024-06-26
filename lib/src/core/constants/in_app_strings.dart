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
  static String getViToEnSingleWordTranslateQuestion(String word) {
    final listTopic1 = Properties
        .instance.settings.dictionaryResponseSelectedListVietnamese
        .replaceAll(DefaultSettings.dictionaryResponseVietnameseConstant, '');
    final listTopic2 = listTopic1.replaceAll(
        DefaultSettings.dictionaryResponseEnglishConstant, '');
    var listString = '';
    if (listTopic2.trim().replaceAll(',', '').length > 2) {
      listTopic2.split(',').forEach((topic) {
        if (topic.trim() == 'Nguồn gốc' || topic.trim() == 'Etymology') {
          listString += ''
              '● ${topic.trim()}'
              '[Etymology of the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Loại từ' ||
            topic.trim() == 'Part of Speech') {
          listString += ''
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Ghi chú về cách sử dụng' ||
            topic.trim() == 'Usage Notes') {
          listString += '' 
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Từ đồng âm' || topic.trim() == 'Homonyms') {
          listString += ''
              '● ${topic.trim()}'
              '[List of Homonyms of the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Cụm động từ' ||
            topic.trim() == 'Phrasal Verbs') {
          listString += ''
              '● ${topic.trim()}'
              '[Phrasal Verbs from the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Viết tắt' ||
            topic.trim() == 'Abbreviations') {
          listString += ''
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in English';
        } else if (topic.trim() == 'Lưu ý về cách sử dụng' ||
            topic.trim() == 'Notes on Usage') {
          listString += ''
              '● ${topic.trim()}'
              '[Notes on Usage of the word "[${word.trim()}] in English"]';
        } else if (topic.length > 2) {
          listString += ''
              '● ${topic.trim()}'
              ''
              'Definition: [definition in ${topic.trim().i18nEnglish}] context in English]'
              'Example:'
              ''
              '1.  [Example sentence in ${topic.trim().i18nEnglish} in Vietnamese] ([Example sentence in English])'
              '2.  [Example sentence in ${topic.trim().i18nEnglish} in Vietnamese] ([Example sentence in English])';
        }
      });
    }
    return 'Translate the Vietnamese word "[${word.trim()}]" to English and provide the response in the exact following format:'
        ''
        'Pronunciation: /[pronunciation in Vietnamese]/'
        'Definition: [different definitions in English]'
        'Example:'
        ''
        '1.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '2.  [Example sentence in Vietnamese] ([Example sentence in English])'
        '3.  [Example sentence in Vietnamese] ([Example sentence in English])'
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
      listTopic2.split(',').forEach((topic) {
        if (topic.trim() == 'Nguồn gốc' || topic.trim() == 'Etymology') {
          listString += ''
              '● ${topic.trim()}'
              '[Etymology of the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Loại từ' ||
            topic.trim() == 'Part of Speech') {
          listString += ''
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Ghi chú về cách sử dụng' ||
            topic.trim() == 'Usage Notes') {
          listString += ''
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Từ đồng âm' || topic.trim() == 'Homonyms') {
          listString += ''
              '● ${topic.trim()}'
              '[List of Homonyms of the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Cụm động từ' ||
            topic.trim() == 'Phrasal Verbs') {
          listString += ''
              '● ${topic.trim()}'
              '[Phrasal Verbs from the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Viết tắt' ||
            topic.trim() == 'Abbreviations') {
          listString += ''
              '● ${topic.trim()}'
              '[Part of speech of the word "[${word.trim()}]"] in Vietnamese';
        } else if (topic.trim() == 'Lưu ý về cách sử dụng' ||
            topic.trim() == 'Notes on Usage') {
          listString += ''
              '● ${topic.trim()}'
              '[Notes on Usage of the word "[${word.trim()}] in Vietnamese"]';
        } else if (topic.length > 2) {
          listString += ''
              '● ${topic.trim()}'
              ''
              'Định nghĩa: [definition in ${topic.trim().i18nEnglish}] context in Vietnamese]'
              'Ví dụ:'
              ''
              '1.  [Example sentence in ${topic.trim().i18nEnglish} in English] ([Example sentence in Vietnamese])'
              '2.  [Example sentence in ${topic.trim().i18nEnglish} in English] ([Example sentence in Vietnamese])';
        }
      });
    }
    return 'Translate the English word "[${word.trim()}]" to Vietnamese and provide the response in the exact following format:'
        ''
        'Phiên âm: /[pronunciation in English]/'
        'Định nghĩa: [different definitions in Vietnamese]'
        'Ví dụ:'
        ''
        '1.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '2.  [Example sentence in English] ([Example sentence in Vietnamese])'
        '3.  [Example sentence in English] ([Example sentence in Vietnamese])'
        ''
        '$listString';
  }

  static String getEnToViParagraphTranslateQuestion(String word) {
    return 'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: $word';
  }
}
