class Setting {
  final String themeMode;
  final int numberOfSynonyms;
  final int numberOfAntonyms;
  final bool enableAdaptiveTheme;
  final int openAppCount;
  final double readingFontSize;
  final int numberOfEssentialLeft;
  final double readingFontSizeSliderValue;
  final String language;
  final String dictionaryResponseSelectedList;
  final double windowsWidth;
  final double windowsHeight;
  final String translationChoice;
  final String dictionaryResponseType;
  final int themeColor;
  Setting(
      {
        required this.dictionaryResponseType,
        required this.translationChoice,
        required this.themeColor,
        required this.openAppCount,
      required this.readingFontSizeSliderValue,
      required this.themeMode,
      required this.numberOfSynonyms,
      required this.enableAdaptiveTheme,
      required this.numberOfAntonyms,
      required this.readingFontSize,
      required this.numberOfEssentialLeft,
      required this.language,
      required this.dictionaryResponseSelectedList,
      required this.windowsWidth,
      required this.windowsHeight});

  Setting copyWith(
      {
        String? dictionaryResponseType,
        String? translationChoice,
      String? themeMode,
      int? themeColor,
      int? numberOfSynonyms,
      int? numberOfAntonyms,
        int? openAppCount,
        bool? enableAdaptiveTheme,
      double? readingFontSize,
      int? numberOfEssentialLeft,
      double? windowsWidth,
      double? windowsHeight,
      double? readingFontSizeSliderValue,
      String? language,
      String? dictionaryResponseSelectedList,
      }) {
    return Setting(
        dictionaryResponseType: dictionaryResponseType ?? this.dictionaryResponseType,
        translationChoice: translationChoice ?? this.translationChoice,
        openAppCount: openAppCount ?? this.openAppCount,
        readingFontSizeSliderValue:
            readingFontSizeSliderValue ?? this.readingFontSizeSliderValue,
        numberOfSynonyms: numberOfSynonyms ?? this.numberOfSynonyms,
        numberOfAntonyms: numberOfAntonyms ?? this.numberOfAntonyms,
        readingFontSize: readingFontSize ?? this.readingFontSize,
      enableAdaptiveTheme: enableAdaptiveTheme ?? this.enableAdaptiveTheme,
        numberOfEssentialLeft:
            numberOfEssentialLeft ?? this.numberOfEssentialLeft,
        language: language ?? this.language,
      dictionaryResponseSelectedList: dictionaryResponseSelectedList ?? this.dictionaryResponseSelectedList,
        windowsWidth: windowsWidth ?? this.windowsWidth,
        windowsHeight: windowsHeight ?? this.windowsHeight,
        themeMode: themeMode ?? this.themeMode,
        themeColor: themeColor ?? this.themeColor,
    );
  }
}
