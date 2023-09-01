import 'dart:convert';

import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/components/head_sentence.dart';
import 'package:diccon_evo/screens/essential/ui/guidance_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../models/3000.dart';
import '../../components/circle_button.dart';
import 'essential.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'learning_page_item.dart';

class LearningView extends StatefulWidget {
  const LearningView({super.key});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  @override
  void initState() {
    loadData("School-supplies");
    // TODO: implement initState
    super.initState();
  }

  loadData(String topic) async {
    final jsonString =
        await rootBundle.loadString('assets/3000/3000_essential_words.json');
    final jsonData = json.decode(jsonString);
    List<EssentialWord> essentialWords = [];

    for (var essentialData in jsonData[topic]!) {
      essentialWords.add(EssentialWord.fromJson(essentialData));
    }

    setState(() {
      _words = essentialWords;
    });
  }

  late List<EssentialWord> _words = [];
  final _pageViewController = PageController();
  final List<String> _listTopic =
  [
    "School-supplies",
    "Actions",
    "Everyday activities",
    "Sea",
    "The number",
    "Shopping",
    "Bedroom",
    "Friendship",
    "Kitchen",
    "Jewelry",
    "Environment",
    "Living room",
    "Hospital",
    "Computer",
    "Housework",
    "The shops",
    "Entertaiment",
    "Traveling",
    "Hometown",
    "Mid-autumn",
    "Wedding",
    "Airport",
    "Health",
    "Vegetable",
    "Transport",
    "Time",
    "Emotions",
    "Character",
    "Drinks",
    "Flowers",
    "Movies",
    "Soccer",
    "Christmas",
    "Foods",
    "Sport",
    "Music",
    "Love",
    "Restaurant-Hotel",
    "School",
    "Colors",
    "Weather",
    "Clothes",
    "Body parts",
    "Education",
    "Family",
    "Fruits",
    "Animal",
    "Insect",
    "Study",
    "Plants",
    "Country",
    "Seafood",
    "Energy",
    "Jobs",
    "Diet",
    "Natural disaster",
    "Asking the way",
    "A hotel room",
    "At the post office",
    "At the bank"
  ];
  var _selectedTopic;
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
                const HeadSentence(listText: [
                  "You're studying",
                  "the subject of",
                ]),
                Row(
                  children: [
                    CircleButton(iconData: FontAwesomeIcons.wandMagicSparkles,
                        onTap: (){

                        }),
                    SizedBox(width: 8,),
                    /// Topic selector
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            style: const TextStyle(
                              fontSize: 18
                            ),
                            value: _selectedTopic,
                            //isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            underline: null,
                            borderRadius: BorderRadius.circular(16),
                            items: _listTopic.map((topic) {
                              return DropdownMenuItem(
                                value: topic,
                                child: Text(topic),
                              );
                            }).toList(),
                            onChanged: (topic) {
                              loadData(topic.toString());
                              setState(() {
                                _selectedTopic = topic;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                /// List page word
                SizedBox(
                  height: 250,
                  child: PageView.builder(
                    controller: _pageViewController,
                    itemCount: _words.length,
                    itemBuilder: (context, index) {
                      return LearningPageItem(
                        word: _words[index].english,
                        phonetic: _words[index].phonetic,
                        vietnamese: _words[index].vietnamese,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
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
                        padding: EdgeInsets.symmetric(horizontal: 16),
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
                        _pageViewController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                    ),
                  ],
                ),
                SizedBox(height: 16,),
                GuidanceBox(
                  title: "Tips",
                  children:
                  ["Read whenever possible.","Write down new words.","Vocally practice new words.","Visually remember words.","Play word games online."].map((text){
                  return Row(
                    children: [
                      Text("- "),
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
