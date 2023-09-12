import 'dart:convert';
import 'dart:ffi';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/helpers/essential_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../config/properties.dart';
import '../../../models/essential_word.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../../commons/tips_box.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'components/learning_page_item.dart';

class LearningView extends StatefulWidget {
  final String topic;
  final List<EssentialWord> listEssentialWord;
  const LearningView(
      {super.key, required this.listEssentialWord, required this.topic});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final _pageViewController = PageController();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CircleButton(
                      iconData: Icons.close,
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ),

                /// Topic
                HeadSentence(listText: [
                  "You're studying".i18n,
                  "the subject of".i18n,
                ]),
                Text(widget.topic,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                    )),

                /// List page word
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 250,
                    child: PageView.builder(
                      onPageChanged: (index) {
                        Properties.defaultEssentialLeft -= 1;
                        Properties.saveSettings(null, null, null, null);
                        print(Properties.defaultEssentialLeft);
                        _currentIndex = index;
                      },
                      controller: _pageViewController,
                      itemCount: widget.listEssentialWord.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: LearningPageItem(
                            currentIndex: index + 1,
                            totalIndex: widget.listEssentialWord.length,
                            word: widget.listEssentialWord[index].english
                                .upperCaseFirstLetter(),
                            phonetic: widget.listEssentialWord[index].phonetic,
                            vietnamese: widget
                                .listEssentialWord[index].vietnamese
                                .upperCaseFirstLetter(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                /// Navigate page
                Row(
                  children: [
                    CircleButtonBar(
                      children: [
                        CircleButton(
                          iconData: FontAwesomeIcons.chevronLeft,
                          onTap: () {
                            _pageViewController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        CircleButton(
                          iconData: FontAwesomeIcons.chevronRight,
                          onTap: () {
                            _pageViewController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),

                    /// Mark as done button
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 8),
                    //   child: Container(
                    //     height: 50,
                    //     padding: const EdgeInsets.symmetric(horizontal: 16),
                    //       decoration: BoxDecoration(
                    //         color: Theme.of(context).primaryColor,
                    //         borderRadius: BorderRadius.circular(32),
                    //       ),
                    //       child: const Center(child: Text("Mark as done"))),
                    // ),
                    /// Heart button
                    CircleButton(
                      iconData: FontAwesomeIcons.heart,
                      onTap: () {
                        EssentialManager.saveEssentialWordToFavourite(
                            widget.listEssentialWord[_currentIndex]);
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                TipsBox(
                  title: "Tips".i18n,
                  children: [
                    "Read whenever possible.".i18n,
                    "Write down new words.".i18n,
                    "Vocally practice new words.".i18n,
                    "Visually remember words.".i18n,
                    "Play word games online.".i18n
                  ].map((text) {
                    return Row(
                      children: [
                        const Text("- "),
                        Text(
                          text,
                          style: TextStyle(),
                        ),
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
