
import '../properties.dart';

class Setting {
  int? numberOfSynonyms;
  int? numberOfAntonyms;
  double? readingFontSize;

  Setting({int? numberOfSynonyms, double? readingFontSize, int? numberOfAntonyms}) {
    this.readingFontSize = readingFontSize ?? Properties.defaultReadingFontSize;
    this.numberOfSynonyms = numberOfSynonyms ?? Properties.defaultNumberOfSynonyms;
    this.numberOfAntonyms = numberOfAntonyms ?? Properties.defaultNumberOfAntonyms;
  }
}