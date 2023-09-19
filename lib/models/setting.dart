class Setting {
  final int numberOfSynonyms;
  final int numberOfAntonyms;
  final double readingFontSize;
  final int numberOfEssentialLeft;
  final double readingFontSizeSliderValue;
  final String language;
  final double windowsWidth;
  final double windowsHeight;
  Setting(
      {required this.readingFontSizeSliderValue,
      required this.numberOfSynonyms,
      required this.numberOfAntonyms,
      required this.readingFontSize,
      required this.numberOfEssentialLeft,
      required this.language,
      required this.windowsWidth,
      required this.windowsHeight});

  Setting copyWith(
      {int? numberOfSynonyms,
      int? numberOfAntonyms,
      double? readingFontSize,
      int? numberOfEssentialLeft,
      double? windowsWidth,
      double? windowsHeight,
      double? readingFontSizeSliderValue,
      String? language}) {
    return Setting(
        readingFontSizeSliderValue:
            readingFontSizeSliderValue ?? this.readingFontSizeSliderValue,
        numberOfSynonyms: numberOfSynonyms ?? this.numberOfSynonyms,
        numberOfAntonyms: numberOfAntonyms ?? this.numberOfAntonyms,
        readingFontSize: readingFontSize ?? this.readingFontSize,
        numberOfEssentialLeft:
            numberOfEssentialLeft ?? this.numberOfEssentialLeft,
        language: language ?? this.language,
        windowsWidth: windowsWidth ?? this.windowsWidth,
        windowsHeight: windowsHeight ?? this.windowsHeight);
  }
}
