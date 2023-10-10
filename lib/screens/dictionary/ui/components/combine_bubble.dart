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

class CombineBubble extends StatefulWidget {
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
  State<CombineBubble> createState() => _CombineBubbleState();
}

class _CombineBubbleState extends State<CombineBubble> {
  final _translationModeStreamController =
      StreamController<TranslationChoices>();

  _scrollToBottom(){
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
    var local = LocalDictionaryBubble(word: widget.wordObjectForLocal);
    var chatbot = ChatbotBubble(
        word: widget.wordForChatbot,
        chatListController: widget.chatListController,
        index: widget.index,
        listChatGptRepository: widget.listChatGptRepository);
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
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(0.0),
              bottomLeft: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 8),
              child: SwitchTranslationBar(selectedItemSet: (selectedItemSet) {
                _translationModeStreamController.add(selectedItemSet.first);
                _scrollToBottom();
              }),
            ),
            StreamBuilder<TranslationChoices>(
                stream: _translationModeStreamController.stream,
                initialData: Properties.defaultSetting.translationChoice.toTranslationChoice(),
                builder: (context, translationChoice) {
                  _scrollToBottom();
                  return Column(children: [
                    Visibility(
                      visible:
                      translationChoice.data! == TranslationChoices.classic,
                      maintainState: true,
                      child: local,
                    ),
                    Visibility(
                      visible: translationChoice.data! == TranslationChoices.ai,
                      maintainState: true,
                      child: chatbot,
                    ),
                  ]);
                })
          ])
        ),
      ),
    );
  }
}
