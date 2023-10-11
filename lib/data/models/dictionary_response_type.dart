enum DictionaryResponseType {
  shortWithOutPronunciation,
  short,
  normal,
  normalWithOutExample,
  normalWithOutPronunciation,
}
extension DictionaryResponseTypeExtenstion on DictionaryResponseType{
  String title(){
    switch(this) {
      case DictionaryResponseType.shortWithOutPronunciation:
        return "shortWithOutPronunciation";
      case DictionaryResponseType.short :
        return "short";
      case DictionaryResponseType.normal:
        return "normal";
      case DictionaryResponseType.normalWithOutExample:
        return "normalWithOutExample";
      case DictionaryResponseType.normalWithOutPronunciation:
        return "normalWithOutPronunciation";
    }

  }
}