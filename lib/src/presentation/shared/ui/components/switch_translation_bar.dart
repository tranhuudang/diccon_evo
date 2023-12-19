import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class SwitchTranslationBar extends StatefulWidget {
  final Function(Set<StoryTranslationChoices> selectedItemSet) selectedItemSet;
  final StoryTranslationChoices? currentValue;
  const SwitchTranslationBar({
    super.key, required this.selectedItemSet, this.currentValue,
  });

  @override
  State<SwitchTranslationBar> createState() =>
      _SwitchTranslationBarState();
}

class _SwitchTranslationBarState extends State<SwitchTranslationBar> {
  final _selectedItemController = StreamController<StoryTranslationChoices>();
  @override
  void dispose(){
    super.dispose();
    _selectedItemController.close();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        StreamBuilder<StoryTranslationChoices>(
          stream: _selectedItemController.stream,
          initialData: widget.currentValue,
          builder: (context, selectedItem) {
            return SegmentedButton<StoryTranslationChoices>(
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
              selected: {selectedItem.data!},
              onSelectionChanged: (newSelection) {
                widget.selectedItemSet(newSelection);
                _selectedItemController.add(newSelection.first);
              },
            );
          }
        ),
      ],
    );
  }
}
