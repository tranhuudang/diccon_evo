import 'package:diccon_evo/src/common/common.dart';

enum TranslationChoices{
  translate,
  explain
}
extension TranslationChoicesTitle on TranslationChoices{
  String title(){
    switch(this) {
      case TranslationChoices.translate:
        return "Definition".i18n;
      case TranslationChoices.explain:
        return "Explanation".i18n;
    }

  }
}