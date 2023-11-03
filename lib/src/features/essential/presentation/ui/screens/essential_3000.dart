import 'dart:math';
import 'package:go_router/go_router.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';

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
  final EssentialWordRepository _essentialWordRepository =
      EssentialWordRepositoryImpl();

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
          backgroundColor: context.theme.colorScheme.surface,
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Responsive(
                  smallSizeDevice: body(context),
                  mediumSizeDevice: body(context),
                  largeSizeDevice: body(context),
                ),
              ),
              const Header(),
            ],
          )),
    );
  }

  Padding body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Head sentence
          const HeadSentence(
            listText: ["Nothing", "Worth Doing", "Ever", "Came Easy"],
          ),

          /// Sub sentence
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            child: Text(
              "SubSentenceInEssentialWord".i18n,
              style: context.theme.textTheme.bodyLarge
                  ?.copyWith(color: context.theme.colorScheme.onSurface),
            ),
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
                      await _essentialWordRepository
                          .loadEssentialData(_selectedTopic)
                          .then(
                            (listEssential) => {
                              context.pushNamed(
                                  RouterConstants.learningFlashCard,
                                  extra: LearningView(
                                    topic: _selectedTopic,
                                    listEssentialWord: listEssential,
                                  ))
                            },
                          );
                    },
                    backgroundColor: context.theme.colorScheme.primary,
                  ),

                  /// Favourite button
                  CircleButton(
                    iconData: FontAwesomeIcons.heart,
                    onTap: () async {
                      await _essentialWordRepository
                          .readFavouriteEssential()
                          .then((listFavourite) => {
                                if (listFavourite.isNotEmpty)
                                  {
                                    context.pushNamed(
                                        RouterConstants.learningFavourite,
                                        extra: FavouriteReviewView(
                                          listEssentialWord: listFavourite,
                                        ))
                                  }
                                else
                                  {
                                    context.showAlertDialogWithoutAction(
                                        title:
                                            "Favourite Chamber is empty".i18n,
                                        content:
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
                      color: context.theme.colorScheme.surfaceVariant,
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
                            style: context.theme.textTheme.labelLarge,
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
                              color: context
                                  .theme.colorScheme.onSecondaryContainer,
                              backgroundColor:
                                  context.theme.colorScheme.secondaryContainer,
                              onTap: () async {
                                /// Load essential word based on provided topic
                                await _essentialWordRepository
                                    .loadEssentialData(topic)
                                    .then(
                                      (listEssential) => {
                                        context.pushNamed(
                                            RouterConstants.learningFlashCard,
                                            extra: LearningView(
                                              topic: topic,
                                              listEssentialWord: listEssential,
                                            ))
                                      },
                                    );
                              },
                              title: topic);
                        }).toList(),
                      ),
                    ],
                  );
                } else {
                  return nil;
                }
              }),
        ],
      ),
    );
  }
}
