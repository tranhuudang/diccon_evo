import 'dart:async';
import 'package:diccon_evo/common/common.dart';
import 'package:flutter/material.dart';

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
  final _selectedItemController = StreamController<TranslationChoices>();
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
        StreamBuilder<TranslationChoices>(
          stream: _selectedItemController.stream,
          initialData: Properties.defaultSetting.translationChoice.toTranslationChoice(),
          builder: (context, selectedItem) {
            return SegmentedButton<TranslationChoices>(
              showSelectedIcon: true,
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
