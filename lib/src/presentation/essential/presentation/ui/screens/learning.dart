import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../../../../domain/domain.dart';

class LearningView extends StatefulWidget {
  final String topic;
  final List<EssentialWord> listEssentialWord;
  const LearningView(
      {super.key, required this.topic, required this.listEssentialWord});

  @override
  State<LearningView> createState() => _LearningViewState();
}

class _LearningViewState extends State<LearningView> {
  final _learningBloc = LearningBloc();
  @override
  void initState() {
    super.initState();
    _learningBloc.add(InitialLearningEssential(topic: widget.topic));
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadSentence(
                        fontSize: 28,
                        listText: [
                          "You're studying".i18n,
                          "the subject of".i18n,
                        ]),
                    Text(widget.topic,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        )),
                    BlocBuilder<LearningBloc, LearningState>(
                        bloc: _learningBloc,
                        builder: (context, state) {
                          switch (state) {
                            case  LearningUpdatedState _ :
                              return Column(
                                children: [
                                  /// List page word
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                    child: SizedBox(
                                      height: 250,
                                      child: PageView.builder(
                                        onPageChanged: (index) {
                                          _learningBloc
                                              .add(OnPageChanged(currentPageIndex: index));
                                          Properties.instance.saveSettings(Properties.instance.settings
                                              .copyWith(
                                              numberOfEssentialLeft: Properties.instance.settings
                                                  .numberOfEssentialLeft -
                                                  1));
                                          if (kDebugMode) {
                                            print(Properties.instance.settings.numberOfEssentialLeft);
                                          }
                                          currentIndex = index;
                                        },
                                        controller: _learningBloc.pageViewController,
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
                                    controller: _learningBloc.pageViewController,
                                    count: _learningBloc.listEssentialWordByTopic.length,
                                    effect: ScrollingDotsEffect(
                                      maxVisibleDots: 5,
                                      dotHeight: 8,
                                      dotWidth: 8,
                                      activeDotColor: context.theme.colorScheme.primary,
                                      dotColor: context.theme.highlightColor,
                                    ),
                                  ),

                                  /// Navigate page
                                  Row(
                                    children: [
                                      // Only display navigation bar on desktop devices
                                      if (defaultTargetPlatform.isDesktop())
                                        CircleButtonBar(
                                          children: [
                                            CircleButton(
                                              iconData: FontAwesomeIcons.chevronLeft,
                                              onTap: () {
                                                _learningBloc.add(GoToPreviousCard());
                                              },
                                            ),
                                            CircleButton(
                                              iconData: FontAwesomeIcons.chevronRight,
                                              onTap: () {
                                                _learningBloc.add(GoToNextCard());
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
                                      //         color: context.theme.primaryColor,
                                      //         borderRadius: BorderRadius.circular(32),
                                      //       ),
                                      //       child: const Center(child: Text("Mark as done"))),
                                      // ),
                                      /// Heart button
                                      CircleButton(

                                        backgroundColor: state.isCurrentWordFavourite
                                            ? context.theme.colorScheme.primary
                                            : context.theme.highlightColor,
                                        iconData: FontAwesomeIcons.heart,
                                        onTap: () {
                                          if (state.isCurrentWordFavourite) {
                                            _learningBloc.add(RemoveFromFavourite(
                                                word: widget
                                                    .listEssentialWord[currentIndex]));
                                          } else {
                                            _learningBloc.add(AddToFavourite(
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
