import 'package:freezed_annotation/freezed_annotation.dart';
part 'settings.freezed.dart';
@freezed
class Settings with _$Settings {
  const factory Settings({
    /// Save current theme of this app in this param, it holds string value of [ThemeMode] with value:
    /// ThemeMode.system, ThemeMode.dark, ThemeMode.light
    required String themeMode,
    /// Number of Synonyms is the number of Synonyms displayed in dictionary
    required int numberOfSynonyms,
    /// Number of Antonyms is the number of Antonyms displayed in dictionary
    required int numberOfAntonyms,
    /// Adaptive theme use DynamicTheme package to generate colorScheme
    required bool enableAdaptiveTheme,
    /// Open app count will trigger a specific function when user use app for a period of time
    required int openAppCount,
    /// This reading font size used in story reading view
    required double readingFontSize,
    /// Number of word when practice will be count down and save in this property
    required int numberOfEssentialLeft,
    /// Hold slider value of reading font size in settings
    required double readingFontSizeSliderValue,
    /// Language of app, those value : English, Tiếng Việt, System default will be convert
    /// to [Locale('en', 'US')] to change value of the app
    required String language,
    /// Custom for response in dictionary
    required String dictionaryResponseSelectedListVietnamese,
    /// Stream for fast, timeBomb for slow
    required String dictionaryEngine,
    /// Custom for response in dictionary
    required String dictionaryResponseSelectedListEnglish,
    /// Save target translate language with defined language in , currently support:
    /// englishToVietnamese, vietnameseToEnglish, autoDetect
    required String translationLanguageTarget,
    /// Hold windows size value
    required double windowsWidth,
    /// Hold windows size value
    required double windowsHeight,
    /// Hold primary color for the app, it can be generate to other colors later to
    /// create colorScheme
    required int themeColor,
    /// Save selected tab path for desktop device
    required String selectedTab,
    /// Working in login screen, it true when user decide to using the app without login
    required bool continueWithoutLogin,
  }) = _Setting;
}
