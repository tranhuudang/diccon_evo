enum TranslationLanguageTarget{
  englishToVietnamese,
  vietnameseToEnglish,
  autoDetect
}
extension TranslationLanguageTargetExtension on TranslationLanguageTarget{
  String title(){
    switch(this){
      case TranslationLanguageTarget.englishToVietnamese:
        return 'englishToVietnamese';
      case TranslationLanguageTarget.vietnameseToEnglish:
        return 'vietnameseToEnglish';
      case TranslationLanguageTarget.autoDetect:
        return 'autoDetect';
    }
  }
}