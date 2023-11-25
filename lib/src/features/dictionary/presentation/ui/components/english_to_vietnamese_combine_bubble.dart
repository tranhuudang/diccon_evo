import 'dart:async';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';

class EnglishToVietnameseCombineBubble extends StatefulWidget {
  final Word wordObjectForLocal;
  final String wordForChatBot;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  const EnglishToVietnameseCombineBubble(
      {super.key,
      required this.wordObjectForLocal,
      required this.wordForChatBot,
      required this.chatListController,
      required this.index,
      required this.listChatGptRepository});

  @override
  State<EnglishToVietnameseCombineBubble> createState() => _EnglishToVietnameseCombineBubbleState();
}

class _EnglishToVietnameseCombineBubbleState extends State<EnglishToVietnameseCombineBubble> {
  final translationModeStreamController =
      StreamController<TranslationChoices>();
  final listResponseController = PageController();

  scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      widget.chatListController.animateTo(
        widget.chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 500),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var listResponseOptions = [
      EnglishToVietnameseClassicBubble(word: widget.wordObjectForLocal),
      EnglishToVietnameseChatBotBubble(
          word: widget.wordForChatBot,
          chatListController: widget.chatListController,
          index: widget.index,
          listChatGptRepository: widget.listChatGptRepository)
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(
                maxWidth: 600,
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
                  if (Properties.instance.settings.translationChoice.toTranslationChoice() == TranslationChoices.explain){
                    listResponseOptions = listResponseOptions.reversed.toList();
                  }
                  if (widget.wordForChatBot.numberOfWord() > 3) {
                    return EnglishToVietnameseChatBotBubble(
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
                            onPageChanged: (pageIndex) {
                              if (widget.index >=
                                  widget.listChatGptRepository.length - 1) {
                                scrollToBottom();
                              }
                            },
                            children: listResponseOptions,
                          ),
                        ],
                      ),
                      if (defaultTargetPlatform.isDesktop())
                        PageViewNavigator(
                            height: 158,
                            backgroundColor: context.theme.colorScheme.onPrimary,

                            controller: listResponseController,
                            itemCount: listResponseOptions.length)
                    ],
                  );
                  }
                },
              ),
            ),
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
      ),
    );
  }
}
