import 'dart:convert';

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/helpers/essential_manager.dart';
import 'package:diccon_evo/screens/components/head_sentence.dart';
import 'package:diccon_evo/screens/components/tips_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/essential_word.dart';
import '../../components/circle_button.dart';
import 'essential.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'components/learning_page_item.dart';

class LearningView extends StatefulWidget {
  final String topic;
  final List<EssentialWord> listEssentialWord;
  const LearningView({super.key, required this.listEssentialWord, required this.topic});

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
  int _currentIndex =0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
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
                  "You're studying",
                  "the subject of",
                  (widget.topic)
                ]),
                /// List page word
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 250,
                    child: PageView.builder(
                      onPageChanged: (index){
                        _currentIndex = index;
                      },
                      controller: _pageViewController,
                      itemCount: widget.listEssentialWord.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: LearningPageItem(
                            currentIndex: index+1,
                            totalIndex: widget.listEssentialWord.length,
                            word: widget.listEssentialWord[index].english.upperCaseFirstLetter(),
                            phonetic: widget.listEssentialWord[index].phonetic,
                            vietnamese: widget.listEssentialWord[index].vietnamese.upperCaseFirstLetter(),
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
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CircleButton(
                          iconData: FontAwesomeIcons.chevronRight,
                          onTap: () {
                            _pageViewController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ],
                    ),
                    const Spacer(),
                    /// Mark as done button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: const Center(child: Text("Mark as done"))),
                    ),
                    /// Heart button
                    CircleButton(
                      iconData: FontAwesomeIcons.heart,
                      onTap: () {
                        EssentialManager.saveEssentialWordToFavourite(widget.listEssentialWord[_currentIndex]);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                TipsBox(
                  title: "Tips",
                  children:
                  ["Read whenever possible.","Write down new words.","Vocally practice new words.","Visually remember words.","Play word games online."].map((text){
                  return Row(
                    children: [
                      const Text("- "),
                      Text(text, style: TextStyle(),),
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
