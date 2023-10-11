enum TranslationChoices{
  classic,
  ai
}
extension TranslationChoicesTitle on TranslationChoices{
  String title(){
    switch(this) {
      case TranslationChoices.classic:
        return "Classic";
      case TranslationChoices.ai:
        return "AI";
    }

  }
}