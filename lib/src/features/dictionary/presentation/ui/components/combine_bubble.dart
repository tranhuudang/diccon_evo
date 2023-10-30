import 'dart:async';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import '../../../../../common/data/models/word.dart';

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
  final translationModeStreamController =
  StreamController<TranslationChoices>();

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
          decoration: BoxDecoration(
            color: context.theme.colorScheme.secondary,
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
                  if (widget.index >= widget.listChatGptRepository.length - 1) {
                    scrollToBottom();
                  }
                }),
              ),
              StreamBuilder<TranslationChoices>(
                stream: translationModeStreamController.stream,
                initialData: Properties.defaultSetting.translationChoice
                    .toTranslationChoice(),
                builder: (context, translationChoice) {
                  if (widget.wordObjectForLocal.definition ==
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
