import 'dart:async';
import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/chatbot_buble_preview.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/user_bubble_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../data/data_providers/chat_preview_list_data.dart';
import '../../../data/models/dictionary_response_type.dart';
import '../../commons/section.dart';
import 'components/pageview_navigator.dart';

class DictionaryPreferencesTest extends StatefulWidget {
  const DictionaryPreferencesTest({super.key});

  @override
  State<DictionaryPreferencesTest> createState() =>
      _DictionaryPreferencesTestState();
}

class _DictionaryPreferencesTestState extends State<DictionaryPreferencesTest> {
  List<String> listSelected = Properties.defaultSetting.dictionaryResponseSelectedList.split(", ") ;
  List<String> listChoices = [
    "Pronunciation",
    "Definitions",
    "Examples",
    "Etymology",
    "Part of Speech",
    "Usage Notes",
    "Related Words",
    "Collocations",
    "Regional Variations",
    "Cultural or Historical Context",
    "Derived Terms",
    "Phrasal Verbs",
    "Abbreviations or Acronyms",
    "Related Concepts",
    "Usage Frequency",
    "Notes on Usage",
    "Word Forms",
  ];
  List<String> listSpecializedFields = [
    "Medical Terminology",
    "Legal Terminology",
    "Scientific Terminology",
    "Technical Jargon",
    "Financial and Economic Terms",
    "Environmental Science",
    "Linguistics",
    "Mathematics",
    "Art and Art History",
    "Music Theory",
    "Psychology",
    "Philosophy",
    "Astronomy",
    "Geology",
    "Botany",
    "Zoology",
    "Architecture",
    "History",
    "Food and Culinary Arts",
    "Fashion and Clothing",
    "Sports and Athletics",
    "Travel and Tourism",
    "Aviation and Aerospace",
    "Maritime and Nautical",
    "Automotive and Transportation",
  ];

  void _compileSelectedItems() {
    final convertedString =  listSelected.join(", "); // Joins the items with a space
    Properties.saveSettings(Properties.defaultSetting.copyWith(dictionaryResponseSelectedList:convertedString ));
    Properties.defaultSetting = Properties.defaultSetting.copyWith(dictionaryResponseSelectedList:convertedString );
  }
  void _addItemToLists(
      {required String item, required List<String> targetList}) {
    setState(() {
      targetList.add(item);
    });
  }

  void _removeItemInLists(
      {required String item, required List<String> targetList}) {
    setState(() {
      targetList.remove(item);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Section(
                    title:
                        "Customize the AI response format."
                            .i18n,
                    children: [
                      Wrap(
                        spacing: 3,
                        runSpacing: 3,
                        children: listSelected
                            .map((item) => ActionChip(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  label: Text(
                                    item.i18n,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSecondary),
                                  ),
                                  onPressed: () {
                                    _removeItemInLists(
                                        item: item, targetList: listSelected);
                                    // rebuild list selected item and save it to setting
                                    _compileSelectedItems();
                                  },
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                  Section(
                    title: "Available options".i18n,
                    children: [
                      Wrap(
                        spacing: 3,
                        runSpacing: 3,
                        children: listChoices.map((item) {
                          bool isSelected = false;
                          if (listSelected.contains(item)) isSelected = true;
                          return ChoiceChip(
                            label: Text(item.i18n),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                _addItemToLists(
                                    item: item, targetList: listSelected);
                                // rebuild list selected item and save it to setting
                                _compileSelectedItems();
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Section(
                    title: "Specialized Meanings".i18n,
                    children: [
                      Wrap(
                        spacing: 3,
                        runSpacing: 3,
                        children: listSpecializedFields.map((item) {
                          bool isSelected = false;
                          if (listSelected.contains(item)) isSelected = true;
                          return ChoiceChip(
                            label: Text(item.i18n),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                _addItemToLists(
                                    item: item, targetList: listSelected);
                                // rebuild list selected item and save it to setting
                                _compileSelectedItems();
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Header(
              title: "Custom Test".i18n,
              actions: const [],
            ),
          ],
        ),
      ),
    );
  }
}
