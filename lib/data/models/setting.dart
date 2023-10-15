class Setting {
  final String themeMode;
  final int numberOfSynonyms;
  final int numberOfAntonyms;

  final int openAppCount;
  final double readingFontSize;
  final int numberOfEssentialLeft;
  final double readingFontSizeSliderValue;
  final String language;
  final double windowsWidth;
  final double windowsHeight;
  final String translationChoice;
  final String dictionaryResponseType;
  Setting(
      {
        required this.dictionaryResponseType,
        required this.translationChoice,
        required this.openAppCount,
      required this.readingFontSizeSliderValue,
      required this.themeMode,
      required this.numberOfSynonyms,
      required this.numberOfAntonyms,
      required this.readingFontSize,
      required this.numberOfEssentialLeft,
      required this.language,
      required this.windowsWidth,
      required this.windowsHeight});

  Setting copyWith(
      {
        String? dictionaryResponseType,
        String? translationChoice,
      String? themeMode,
      int? numberOfSynonyms,
      int? numberOfAntonyms,
        int? openAppCount,
      double? readingFontSize,
      int? numberOfEssentialLeft,
      double? windowsWidth,
      double? windowsHeight,
      double? readingFontSizeSliderValue,
      String? language}) {
    return Setting(
        dictionaryResponseType: dictionaryResponseType ?? this.dictionaryResponseType,
        translationChoice: translationChoice ?? this.translationChoice,
        openAppCount: openAppCount ?? this.openAppCount,
        readingFontSizeSliderValue:
            readingFontSizeSliderValue ?? this.readingFontSizeSliderValue,
        numberOfSynonyms: numberOfSynonyms ?? this.numberOfSynonyms,
        numberOfAntonyms: numberOfAntonyms ?? this.numberOfAntonyms,
        readingFontSize: readingFontSize ?? this.readingFontSize,
        numberOfEssentialLeft:
            numberOfEssentialLeft ?? this.numberOfEssentialLeft,
        language: language ?? this.language,
        windowsWidth: windowsWidth ?? this.windowsWidth,
        windowsHeight: windowsHeight ?? this.windowsHeight,
        themeMode: themeMode ?? this.themeMode);
  }
}
