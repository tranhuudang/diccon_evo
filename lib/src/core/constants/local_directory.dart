import 'dart:math';

class LocalDirectory {
  // data
  static const String enSynonymsPath = 'assets/thesaurus/english_synonyms.json';
  static const String enAntonymsPath = 'assets/thesaurus/english_antonyms.json';
  static const String suggestionListPath = 'assets/dictionary/109k.txt';
  static const String dicconLogo256 = 'assets/diccon-256.png';

  // illustrations
  static const List<String> illustrations = [
    'assets/illustrations/absurd.design - Chapter 1 - 01.png',
    'assets/illustrations/absurd.design - Chapter 1 - 02.png',
    'assets/illustrations/absurd.design - Chapter 1 - 03.png',
    'assets/illustrations/absurd.design - Chapter 1 - 04.png',
    'assets/illustrations/absurd.design - Chapter 1 - 05.png',
    'assets/illustrations/absurd.design - Chapter 1 - 06.png',
    'assets/illustrations/absurd.design - Chapter 1 - 07.png',
    'assets/illustrations/absurd.design - Chapter 1 - 08.png',
    'assets/illustrations/absurd.design - Chapter 1 - 09.png',
    'assets/illustrations/absurd.design - Chapter 1 - 10.png',
    'assets/illustrations/absurd.design - Chapter 1 - 11.png',
    'assets/illustrations/absurd.design - Chapter 1 - 31.png',
    'assets/illustrations/absurd.design - Chapter 1 - 32.png',
    'assets/illustrations/absurd.design - Chapter 1 - 33.png',
    'assets/illustrations/absurd.design - Chapter 1 - 34.png',
  ];
  static final String historyIllustration = getRandomIllustrationImage();
  static final String dictionaryIllustration = getRandomIllustrationImage();
  static final String conversationIllustration = getRandomIllustrationImage();
  static final String textRecognizerIllustration = getRandomIllustrationImage();
  static final String commonIllustration = getRandomIllustrationImage();
  static String getRandomIllustrationImage() {
    int randomIndex = Random().nextInt(illustrations.length);
    return illustrations[randomIndex];
  }
  //
  static const String essentialWordFileName =
      "assets/essential/3000_essential_words.json";
  static const String wordHistoryFileName = 'dictionary_history.json';
  static const String topicHistoryFileName = 'topic_history.json';
  static const String storyHistoryFileName = 'story_history.json';
  static const String storyBookmarkFileName = 'story_bookmark.json';
  static const String essentialFavouriteFileName = 'essential_favourite.json';
  static const String extendStoryFileName = 'extend_story.json';
  static const String rootFolderName = 'Diccon';
  static const String userDataFolderName = 'User Data';
  static const String resourcesDataFolderName = 'Resources';
}
