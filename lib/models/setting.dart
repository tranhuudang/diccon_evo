
import '../../config/properties.dart';

class Setting {
  int? numberOfSynonyms;
  int? numberOfAntonyms;
  double? readingFontSize;
  int? numberOfEssentialLeft;
  String? language;
  Setting({int? numberOfSynonyms, double? readingFontSize, int? numberOfAntonyms, int? numberOfEssentialLeft, String? language}) {
    this.numberOfSynonyms = numberOfSynonyms ?? Properties.defaultNumberOfSynonyms;
    this.numberOfAntonyms = numberOfAntonyms ?? Properties.defaultNumberOfAntonyms;
    this.readingFontSize = readingFontSize ?? Properties.defaultReadingFontSize;
    this.numberOfEssentialLeft = numberOfEssentialLeft ?? Properties.defaultEssentialLeft;
    this.language = language ?? Properties.defaultLanguage;
  }
}