import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SwitchTranslationBar extends StatefulWidget {
  final Function(Set<StoryTranslationChoices> selectedItemSet) selectedItemSet;
  final StoryTranslationChoices currentValue;

  const SwitchTranslationBar({
    super.key,
    required this.selectedItemSet,
    required this.currentValue,
  });

  @override
  State<SwitchTranslationBar> createState() => _SwitchTranslationBarState();
}

class _SwitchTranslationBarState extends State<SwitchTranslationBar> {
  late StoryTranslationChoices _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.currentValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SegmentedButton<StoryTranslationChoices>(
          showSelectedIcon: false,
          segments: [
            ButtonSegment(
              value: StoryTranslationChoices.translate,
              label: Text(StoryTranslationChoices.translate.title()),
            ),
            ButtonSegment(
              value: StoryTranslationChoices.explain,
              label: Text(StoryTranslationChoices.explain.title()),
            ),
          ],
          selected: {_selectedItem},
          onSelectionChanged: (newSelection) {
            setState(() {
              _selectedItem = newSelection.first;
            });
            widget.selectedItemSet(newSelection);
          },
        ),
      ],
    );
  }
}
