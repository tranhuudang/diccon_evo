import 'package:flutter/material.dart';


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
class SwitchTranslationBar extends StatefulWidget {
  final Function(Set<TranslationChoices> selectedItemSet) selectedItemSet;
  const SwitchTranslationBar({
    super.key, required this.selectedItemSet,
  });

  @override
  State<SwitchTranslationBar> createState() =>
      _SwitchTranslationBarState();
}

class _SwitchTranslationBarState extends State<SwitchTranslationBar> {
  TranslationChoices selectedItem = TranslationChoices.classic;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Spacer(),
        SegmentedButton<TranslationChoices>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: TranslationChoices.classic,
              label: Text(TranslationChoices.classic.title()),
            ),
            ButtonSegment(
              value: TranslationChoices.ai,
              label: Text(TranslationChoices.ai.title()),
            ),
          ],
          selected: {selectedItem},
          onSelectionChanged: (newSelection) {
            widget.selectedItemSet(newSelection);
            setState(() {
              selectedItem = newSelection.first;
            });
          },
        ),
      ],
    );
  }
}
