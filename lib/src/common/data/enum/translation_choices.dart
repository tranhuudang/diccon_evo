enum TranslationChoices{
  translate,
  explain
}
extension TranslationChoicesTitle on TranslationChoices{
  String title(){
    switch(this) {
      case TranslationChoices.translate:
        return "Classic";
      case TranslationChoices.explain:
        return "AI";
    }

  }
}