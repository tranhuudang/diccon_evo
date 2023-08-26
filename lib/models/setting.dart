
import '../../config/properties.dart';

class Setting {
  int? numberOfSynonyms;
  int? numberOfAntonyms;

  Setting({int? numberOfSynonyms, double? readingFontSize, int? numberOfAntonyms}) {
    this.numberOfSynonyms = numberOfSynonyms ?? Properties.defaultNumberOfSynonyms;
    this.numberOfAntonyms = numberOfAntonyms ?? Properties.defaultNumberOfAntonyms;
  }
}