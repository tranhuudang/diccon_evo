import 'dart:async';
import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/screens/commons/switch_translation_bar.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/chatbot_buble.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/local_dictionary_bubble.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/translation_choices.dart';
import '../../../../data/models/word.dart';
import '../../../../data/repositories/chat_gpt_repository.dart';

class CombineBubble extends StatelessWidget {
  final Word wordObjectForLocal;
  final String wordForChatbot;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  const CombineBubble(
      {super.key,
      required this.wordObjectForLocal,
      required this.wordForChatbot,
      required this.chatListController,
      required this.index,
      required this.listChatGptRepository});

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Padding body(BuildContext context) {
    final translationModeStreamController =
        StreamController<TranslationChoices>();

    scrollToBottom() {
      Future.delayed(const Duration(milliseconds: 300), () {
        chatListController.animateTo(
          chatListController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.linear,
        );
      });
    }

    var local = LocalDictionaryBubble(word: wordObjectForLocal);
    var chatbot = ChatbotBubble(
        word: wordForChatbot,
        chatListController: chatListController,
        index: index,
        listChatGptRepository: listChatGptRepository);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 600,
          ),
          //height: _isTooLarge ? 500 : null,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, right: 8),
                child: SwitchTranslationBar(selectedItemSet: (selectedItemSet) {
                  translationModeStreamController.add(selectedItemSet.first);
                  // Only scroll to the bottom when switch translation mode changed on the lastest widget bubble
                  if (index >= listChatGptRepository.length - 1) {
                    scrollToBottom();
                  }
                }),
              ),
              StreamBuilder<TranslationChoices>(
                stream: translationModeStreamController.stream,
                initialData: Properties.defaultSetting.translationChoice
                    .toTranslationChoice(),
                builder: (context, translationChoice) {
                  if (wordObjectForLocal.meaning ==
                      "Local dictionary don't have definition for this word. Check out AI Dictionary !") {
                    translationModeStreamController.add(TranslationChoices.ai);
                  }
                  return Column(
                    children: [
                      Visibility(
                        visible: translationChoice.data! ==
                            TranslationChoices.classic,
                        maintainState: true,
                        child: local,
                      ),
                      Visibility(
                        visible:
                            translationChoice.data! == TranslationChoices.ai,
                        maintainState: true,
                        child: chatbot,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
