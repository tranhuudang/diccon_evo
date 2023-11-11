import 'package:diccon_evo/src/common/common.dart';

enum StoryTranslationChoices{
  translate,
  explain
}
extension StoryTranslationChoicesTitle on StoryTranslationChoices{
  String title(){
    switch(this) {
      case StoryTranslationChoices.translate:
        return "Definition".i18n;
      case StoryTranslationChoices.explain:
        return "Explanation".i18n;
    }

  }
}