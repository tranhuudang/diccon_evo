import 'dart:convert';
import 'dart:math';

import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../models/essential_word.dart';
import '../../components/circle_button.dart';
import '../../components/tips_box.dart';
import '../../components/head_sentence.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EssentialView extends StatefulWidget {
  const EssentialView({super.key});

  @override
  State<EssentialView> createState() => _EssentialViewState();
}

class _EssentialViewState extends State<EssentialView> {
  final List<String> _listTopic = [
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

  @override
  initState() {
    _selectedTopic =_listTopic[createRandomValue()];
    super.initState();
  }

  Future<List<EssentialWord>> loadEssentialData(String topic) async {
    final jsonString = await rootBundle
        .loadString('assets/essential/3000_essential_words.json');
    final jsonData = json.decode(jsonString);
    List<EssentialWord> essentialWords = [];

    for (var essentialData in jsonData[topic]!) {
      essentialWords.add(EssentialWord.fromJson(essentialData));
    }
    return essentialWords;
  }

  late String _selectedTopic;

  int createRandomValue() {
    Random random = Random();
    return random.nextInt(_listTopic.length);
  }

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
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: CircleButton(
                    iconData: Icons.arrow_back,
                    onTap: () {
                      Navigator.pop(context);
                    }),
              ),

              /// Head sentence
              const HeadSentence(
                listText: ["Nothing", "Worth Doing", "Ever", "Came Easy"],
              ),

              /// Sub sentence
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
                child: const Text(
                    "Mastering 1848 core English words fosters clear communication. "
                    "Enhanced vocabulary aids reading, writing, speaking, and understanding. "
                    "It facilitates meaningful interactions, empowers expression, "
                    "and broadens access to information and opportunities."),
              ),
              Row(
                children: [
                  /// Function bar
                  CircleButtonBar(
                    children: [
                      CircleButton(
                        iconData: FontAwesomeIcons.play,
                        onTap: () async {
                          if (_selectedTopic != null) {
                            await loadEssentialData(_selectedTopic).then(
                              (listEssential) => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LearningView(
                                      topic: _selectedTopic,
                                      listEssentialWord: listEssential,
                                    ),
                                  ),
                                )
                              },
                            );
                          }
                        },
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircleButton(
                        iconData: Icons.repeat,
                        onTap: () {
                          print("button clicked");
                        },
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CircleButton(
                        iconData: FontAwesomeIcons.heart,
                        onTap: () {
                          print("button clicked");
                        },
                      ),
                    ],
                  ),
                  const Spacer(),

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
                          style: const TextStyle(fontSize: 18),
                          value: _selectedTopic ,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          underline: null,
                          borderRadius: BorderRadius.circular(16),
                          items: _listTopic.map((topic) {
                            return DropdownMenuItem(
                              value: topic,
                              child: Text(topic),
                            );
                          }).toList(),
                          onChanged: (topic) {
                            setState(() {
                              _selectedTopic = topic!;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: 32,
              ),

              /// Guidance box
              const TipsBox(
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_arrow),
                      Text("Start to learn:"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.play_arrow),
                      Text("Review:"),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.play_arrow),
                      Text("Strengthen:"),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
