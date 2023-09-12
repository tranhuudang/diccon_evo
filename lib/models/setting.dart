
import '../../config/properties.dart';

class Setting {
  int? numberOfSynonyms;
  int? numberOfAntonyms;
  double? readingFontSize;
  int? numberOfEssentialLeft;
  Setting({int? numberOfSynonyms, double? readingFontSize, int? numberOfAntonyms, int? numberOfEssentialLeft}) {
    this.numberOfSynonyms = numberOfSynonyms ?? Properties.defaultNumberOfSynonyms;
    this.numberOfAntonyms = numberOfAntonyms ?? Properties.defaultNumberOfAntonyms;
    this.readingFontSize = readingFontSize ?? Properties.defaultReadingFontSize;
    this.numberOfEssentialLeft = numberOfEssentialLeft ?? Properties.defaultEssentialLeft;
  }
}