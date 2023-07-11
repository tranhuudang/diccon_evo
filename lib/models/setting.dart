
import '../global.dart';

class Setting {
  int? numberOfSynonyms;
  int? numberOfAntonyms;
  double? readingFontSize;

  Setting({int? numberOfSynonyms, double? readingFontSize, int? numberOfAntonyms}) {
    this.readingFontSize = readingFontSize ?? Global.defaultReadingFontSize;
    this.numberOfSynonyms = numberOfSynonyms ?? Global.defaultNumberOfSynonyms;
    this.numberOfAntonyms = numberOfAntonyms ?? Global.defaultNumberOfAntonyms;
  }
}