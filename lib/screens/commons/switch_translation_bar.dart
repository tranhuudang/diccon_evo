import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:flutter/material.dart';

import '../../data/models/translation_choices.dart';

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
  TranslationChoices selectedItem = Properties.defaultSetting.translationChoice.toTranslationChoice();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
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
