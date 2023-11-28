import 'package:diccon_evo/src/common/common.dart';
part 'settings.freezed.dart';
@freezed
class Settings with _$Settings {
  const factory Settings({
    required String themeMode,
    required int numberOfSynonyms,
    required int numberOfAntonyms,
    required bool enableAdaptiveTheme,
    required int openAppCount,
    required double readingFontSize,
    required int numberOfEssentialLeft,
    required double readingFontSizeSliderValue,
    required String language,
    required String dictionaryResponseSelectedListVietnamese,
    required String dictionaryResponseSelectedListEnglish,
    required String translationLanguageTarget,
    required double windowsWidth,
    required double windowsHeight,
    required String translationChoice,
    required String dictionaryResponseType,
    required int themeColor,
  }) = _Setting;
}
