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
    return 'Help me translate the word: "${word.trim()}" from Vietnamese to English covering these topics: ${Properties.instance.settings.dictionaryResponseSelectedListEnglish}. Make sure that each vietnamese sentences are immediately followed by their english translations, translated be put in (). Any explanations within the answer must be in english. Make the answer as short as possible';
  }

  static String getViToEnParagraphTranslateQuestion(String word) {
    return 'Help me translate this paragraph to English: $word';
  }

  static String getEnToViSingleWordTranslateQuestion(String word) {
    return 'Help me translate the word: "${word.trim()}" from English to Vietnamese covering these topics: ${Properties.instance.settings.dictionaryResponseSelectedListVietnamese}. Make sure that each english sentences are immediately followed by their vietnamese translations, translated be put in (). Any explanations within the answer must be in vietnamese. Make the answer as short as possible.';
  }

  static String getEnToViParagraphTranslateQuestion(String word) {
    return 'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: $word';
  }
}
