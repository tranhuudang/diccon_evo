import 'dart:math';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/helpers/history_manager.dart';
import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:flutter/material.dart';
import '../../../helpers/essential_manager.dart';
import '../../../helpers/notify.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../../commons/tips_box.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'favourite_review.dart';

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

  late List<String> _listTopicHistory = [];

  @override
  initState() {
    loadTopicHistory();
    _selectedTopic = _listTopic[createRandomValue()];
    super.initState();
  }

  loadTopicHistory() async {
    await HistoryManager.readTopicHistory().then((value) {
      print("topic history");
      setState(() {
        _listTopicHistory = value;
        print("list history");
        print(_listTopicHistory);
      });
    });
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
                child: Text("Mastering 1848 core English words fosters clear communication. "
                        "Enhanced vocabulary aids reading, writing, speaking, and understanding. "
                        "It facilitates meaningful interactions, empowers expression, "
                        "and broadens access to information and opportunities."
                    .i18n),
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
                            /// Add topic to history
                            HistoryManager.saveTopicToHistory(_selectedTopic);

                            /// Load essential word based on provided topic
                            await EssentialManager.loadEssentialData(
                                    _selectedTopic)
                                .then(
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
                      // const SizedBox(
                      //   width: 8,
                      // ),
                      /// Favourite button
                      CircleButton(
                        iconData: FontAwesomeIcons.heart,
                        onTap: () async {
                          await EssentialManager.readFavouriteEssential()
                              .then((listFavourite) => {
                                    if (listFavourite.isNotEmpty)
                                      {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                FavouriteReviewView(
                                              listEssentialWord: listFavourite,
                                            ),
                                          ),
                                        )
                                      }
                                    else
                                      {
                                        Notify.showAlertDialog(
                                            context,
                                            "Favourite Chamber is empty".i18n,
                                            "You have the option to include newly learned words in your \"Favorite Chamber\" as you begin the process of learning them.")
                                      },
                                  });
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
                          value: _selectedTopic,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          underline: null,
                          borderRadius: BorderRadius.circular(16),
                          items: _listTopic.map((topic) {
                            return DropdownMenuItem(
                              value: topic,
                              child: Text(
                                topic,
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
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
              TipsBox(
                title: "Guid".i18n,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      children: [
                        const Icon(FontAwesomeIcons.play, size: 16),
                        const SizedBox(width: 8),
                        Text("Start your journey exploring new words.".i18n),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(FontAwesomeIcons.heart, size: 16),
                      const SizedBox(width: 8),
                      Text("Revise the words you enjoy.".i18n),
                    ],
                  ),
                ],
              ),

              /// Recent History Topic
              SizedBox(
                height: 16,
              ),
              _listTopicHistory.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recent topics".i18n),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          children: _listTopicHistory
                              .map((topic) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: InkWell(
                                      onTap: () async {
                                        print(topic);

                                        /// Load essential word based on provided topic
                                        await EssentialManager
                                                .loadEssentialData(topic)
                                            .then(
                                          (listEssential) => {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    LearningView(
                                                  topic: topic,
                                                  listEssentialWord:
                                                      listEssential,
                                                ),
                                              ),
                                            ),
                                          },
                                        );
                                      },
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          child: Text(topic)),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      )),
    );
  }
}
