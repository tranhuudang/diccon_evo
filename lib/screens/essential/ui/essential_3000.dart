import 'dart:math';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/commons/pill_button.dart';
import 'package:diccon_evo/screens/essential/ui/learning.dart';
import 'package:flutter/material.dart';
import '../../../data/data_providers/essential_manager.dart';
import '../../../data/data_providers/history_manager.dart';
import '../../../data/data_providers/notify.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../../commons/header.dart';
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
    "Entertainment",
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

  late Future<List<String>> _listTopicHistory;

  @override
  initState() {
    _listTopicHistory = HistoryManager.readTopicHistory();
    _selectedTopic = _listTopic[createRandomValue()];
    super.initState();
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
          body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Head sentence
                  const HeadSentence(
                    listText: ["Nothing", "Worth Doing", "Ever", "Came Easy"],
                  ),

                  /// Sub sentence
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 26),
                    child: Text("SubSentenceInEssentialWord".i18n),
                  ),
                  Row(
                    children: [
                      /// Function bar
                      CircleButtonBar(
                        children: [
                          CircleButton(
                            iconData: FontAwesomeIcons.play,
                            onTap: () async {
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
                            },
                            backgroundColor: Theme.of(context).primaryColor,
                          ),

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
                                                  listEssentialWord:
                                                      listFavourite,
                                                ),
                                              ),
                                            )
                                          }
                                        else
                                          {
                                            Notify.showAlertDialog(
                                                context,
                                                "Favourite Chamber is empty"
                                                    .i18n,
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
                                    topic.i18n,
                                    style:
                                        Theme.of(context).textTheme.labelLarge,
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
                            Text(
                                "Start your journey exploring new words.".i18n),
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
                  const SizedBox(
                    height: 16,
                  ),
                  FutureBuilder(
                      future: _listTopicHistory,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Recent topics".i18n),
                              const SizedBox(
                                height: 8,
                              ),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: snapshot.data!.map((topic) {
                                  return PillButton(
                                      onTap: () async {
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
                                      title: topic);
                                }).toList(),
                              ),
                            ],
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ],
              ),
            ),
          ),
          const Header(),
        ],
      )),
    );
  }
}
