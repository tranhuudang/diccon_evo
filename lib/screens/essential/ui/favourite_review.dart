import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../data/models/essential_word.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../../commons/tips_box.dart';
import 'components/learning_page_item.dart';

class FavouriteReviewView extends StatelessWidget {
  final List<EssentialWord> listEssentialWord;
  const FavouriteReviewView({super.key, required this.listEssentialWord});

  @override
  Widget build(BuildContext context) {
    final pageViewController = PageController();
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
                  "Reinforce".i18n,
                  "your".i18n,
                  "knowledge".i18n
                ]),
                /// List page word
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: SizedBox(
                    height: 250,
                    child: PageView.builder(
                      controller: pageViewController,
                      itemCount: listEssentialWord.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(1),
                          child: LearningPageItem(
                            currentIndex: index+1,
                            totalIndex: listEssentialWord.length,
                            word: listEssentialWord[index].english.upperCaseFirstLetter(),
                            phonetic: listEssentialWord[index].phonetic,
                            vietnamese: listEssentialWord[index].vietnamese.upperCaseFirstLetter(),
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
                            pageViewController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        // const SizedBox(
                        //   width: 8,
                        // ),
                        CircleButton(
                          iconData: FontAwesomeIcons.chevronRight,
                          onTap: () {
                            pageViewController.nextPage(
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
                    // CircleButton(
                    //   iconData: FontAwesomeIcons.heart,
                    //   onTap: () {
                    //     EssentialManager.saveEssentialWordToFavourite(widget.listEssentialWord[_currentIndex]);
                    //   },
                    // ),
                  ],
                ),
                const SizedBox(height: 16,),
                TipsBox(
                  title: "Tips".i18n,
                  children:
                  ["Read whenever possible.".i18n,"Write down new words.".i18n,"Vocally practice new words.".i18n,"Visually remember words.".i18n,"Play word games online.".i18n].map((text){
                    return Row(
                      children: [
                        const Text("- "),
                        Text(text),
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
