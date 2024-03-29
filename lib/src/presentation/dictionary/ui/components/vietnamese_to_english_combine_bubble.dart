import 'dart:async';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../../domain/domain.dart';

class VietnameseToEnglishCombineBubble extends StatefulWidget {
  final Word wordObjectForLocal;
  final String wordForChatBot;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  const VietnameseToEnglishCombineBubble(
      {super.key,
      required this.wordObjectForLocal,
      required this.wordForChatBot,
      required this.chatListController,
      required this.index,
      required this.listChatGptRepository});

  @override
  State<VietnameseToEnglishCombineBubble> createState() =>
      _VietnameseToEnglishCombineBubbleState();
}

class _VietnameseToEnglishCombineBubbleState
    extends State<VietnameseToEnglishCombineBubble> {
  final translationModeStreamController =
      StreamController<TranslationChoices>();
  final listResponseController = PageController();

  @override
  Widget build(BuildContext context) {
    var listResponseOptions = [
      VietnameseToEnglishClassicBubble(word: widget.wordObjectForLocal),
      VietnameseToEnglishChatBotBubble(
          word: widget.wordForChatBot,
          chatListController: widget.chatListController,
          index: widget.index,
          listChatGptRepository: widget.listChatGptRepository)
    ];

    return ResponsiveApp(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 86.sw,
                  minWidth: 28.sw,
                ),
                //height: _isTooLarge ? 500 : null,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: StreamBuilder<TranslationChoices>(
                  stream: translationModeStreamController.stream,
                  initialData: Properties.instance.settings.translationChoice
                      .toTranslationChoice(),
                  builder: (context, translationChoice) {
                    if (Properties.instance.settings.translationChoice
                            .toTranslationChoice() ==
                        TranslationChoices.explain) {
                      listResponseOptions =
                          listResponseOptions.reversed.toList();
                    }
                    if (widget.wordForChatBot.numberOfWord() > 3) {
                      return VietnameseToEnglishChatBotBubble(
                          isParagraph: true,
                          word: widget.wordForChatBot,
                          chatListController: widget.chatListController,
                          index: widget.index,
                          listChatGptRepository: widget.listChatGptRepository);
                    } else {
                      return Stack(
                        children: [
                          Column(
                            children: [
                              ExpandablePageView(
                                controller: listResponseController,
                                children: listResponseOptions,
                              ),
                              WaveDivider(
                                thickness: .3,
                                color: context.theme.colorScheme.onSecondary,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: context.theme.colorScheme.secondary,
                                  //color: Colors.red,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(16.0),
                                    bottomRight: Radius.circular(16.0),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    16.width,
                                    PlaybackButton(
                                      message: widget.wordForChatBot.trim(),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                        onPressed: () {
                                          listResponseController.previousPage(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(
                                          Icons.arrow_back,
                                          color: context
                                              .theme.colorScheme.onSecondary,
                                        )),
                                    8.width,
                                    IconButton(
                                        onPressed: () {
                                          listResponseController.nextPage(
                                              duration: const Duration(
                                                  milliseconds: 200),
                                              curve: Curves.easeIn);
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                          color: context
                                              .theme.colorScheme.onSecondary,
                                        )),
                                    16.width,
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              if (defaultTargetPlatform.isMobile())
                if (!(widget.wordForChatBot.numberOfWord() >= 3))
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SmoothPageIndicator(
                      controller: listResponseController,
                      count: listResponseOptions.length,
                      effect: ScrollingDotsEffect(
                        maxVisibleDots: 5,
                        dotHeight: 8,
                        dotWidth: 8,
                        activeDotColor: context.theme.colorScheme.primary,
                        dotColor: context.theme.highlightColor,
                      ),
                    ),
                  ),
            ],
          ),
        ],
      );
    });
  }
}
