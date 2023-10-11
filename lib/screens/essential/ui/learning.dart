import 'package:diccon_evo/config/responsive.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/extensions/target_platform.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import '../../../config/properties.dart';
import '../../../data/models/essential_word.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../bloc/learning_bloc.dart';
import 'components/learning_page_item.dart';

class LearningView extends StatefulWidget {
  final String topic;
  final List<EssentialWord> listEssentialWord;
  const LearningView(
      {super.key, required this.topic, required this.listEssentialWord});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  final learningBloc = LearningBloc();
  @override
  void initState() {
    super.initState();
    learningBloc.add(InitialLearningEssential(topic: widget.topic));
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
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
                        context.pop();
                      }),
                ),

                /// Topic
                Responsive(
                  smallSizeDevice: body(currentIndex),
                  mediumSizeDevice: body(currentIndex),
                  largeSizeDevice: body(currentIndex),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column body(int currentIndex) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeadSentence(listText: [
          "You're studying".i18n,
          "the subject of".i18n,
        ]),
        Text(widget.topic,
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
            )),
        BlocBuilder<LearningBloc, LearningState>(
            bloc: learningBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case LearningUpdatedState:
                  var data = state as LearningUpdatedState;
                  return Column(
                    children: [
                      /// List page word
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: SizedBox(
                          height: 250,
                          child: PageView.builder(
                            onPageChanged: (index) {
                              learningBloc
                                  .add(OnPageChanged(currentPageIndex: index));
                              Properties.saveSettings(Properties.defaultSetting
                                  .copyWith(
                                      numberOfEssentialLeft: Properties
                                              .defaultSetting
                                              .numberOfEssentialLeft -
                                          1));
                              if (kDebugMode) {
                                print(Properties
                                    .defaultSetting.numberOfEssentialLeft);
                              }
                              currentIndex = index;
                            },
                            controller: learningBloc.pageViewController,
                            itemCount: widget.listEssentialWord.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(1),
                                child: LearningPageItem(
                                  currentIndex: index + 1,
                                  totalIndex: widget.listEssentialWord.length,
                                  word: widget.listEssentialWord[index].english
                                      .upperCaseFirstLetter(),
                                  phonetic:
                                      widget.listEssentialWord[index].phonetic,
                                  vietnamese: widget
                                      .listEssentialWord[index].vietnamese
                                      .upperCaseFirstLetter(),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: learningBloc.pageViewController,
                        count: learningBloc.listEssentialWordByTopic.length,
                        effect: ScrollingDotsEffect(
                          maxVisibleDots: 5,
                          dotHeight: 8,
                          dotWidth: 8,
                          activeDotColor: Theme.of(context).primaryColor,
                          dotColor: Theme.of(context).highlightColor,
                        ),
                      ),

                      /// Navigate page
                      Row(
                        children: [
                          // Only display navigation bar on desktop devices
                          defaultTargetPlatform.isDesktop()
                              ? CircleButtonBar(
                                  children: [
                                    CircleButton(
                                      iconData: FontAwesomeIcons.chevronLeft,
                                      onTap: () {
                                        learningBloc.add(GoToPreviousCard());
                                      },
                                    ),
                                    CircleButton(
                                      iconData: FontAwesomeIcons.chevronRight,
                                      onTap: () {
                                        learningBloc.add(GoToNextCard());
                                      },
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
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
                            backgroundColor: data.isCurrentWordFavourite
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).highlightColor,
                            iconData: FontAwesomeIcons.heart,
                            onTap: () {
                              if (data.isCurrentWordFavourite) {
                                learningBloc.add(RemoveFromFavourite(
                                    word: widget
                                        .listEssentialWord[currentIndex]));
                              } else {
                                learningBloc.add(AddToFavourite(
                                    word: widget
                                        .listEssentialWord[currentIndex]));
                              }
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      // TipsBox(
                      //   title: "Tips".i18n,
                      //   children: [
                      //     "Read whenever possible.".i18n,
                      //     "Write down new words.".i18n,
                      //     "Vocally practice new words.".i18n,
                      //     "Visually remember words.".i18n,
                      //     "Play word games online.".i18n
                      //   ].map((text) {
                      //     return Row(
                      //       children: [
                      //         const Text("- "),
                      //         Text(text),
                      //       ],
                      //     );
                      //   }).toList(),
                      // )
                    ],
                  );
                default:
                  return Container();
              }
            }),
      ],
    );
  }
}
