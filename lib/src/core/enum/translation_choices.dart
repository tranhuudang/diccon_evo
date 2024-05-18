enum TranslationChoices{
  classic,
  generative_ai
}
extension TranslationChoicesTitle on TranslationChoices{
  String title(){
    switch(this) {
      case TranslationChoices.classic:
        return "Classic";
      case TranslationChoices.generative_ai:
        return "AI";
    }

  }
}