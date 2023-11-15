import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/features/dictionary/presentation/ui/components/chatbot_buble.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class VietnameseToEnglishChatBotBubble extends StatefulWidget {
  const VietnameseToEnglishChatBotBubble({
    super.key,
    this.onWordTap,
    required this.word,
    required this.chatListController,
    required this.index,
    required this.listChatGptRepository,
    this.isParagraph = false,
  });

  final Function(String)? onWordTap;
  final String word;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  final bool isParagraph;

  @override
  State<VietnameseToEnglishChatBotBubble> createState() =>
      _VietnameseToEnglishChatBotBubbleState();
}

class _VietnameseToEnglishChatBotBubbleState
    extends State<VietnameseToEnglishChatBotBubble>
    with AutomaticKeepAliveClientMixin {
  var customQuestion = '';
  late Future<ChatCompletionRequest> _requestFuture;

  Future<ChatCompletionRequest> _getQuestionRequest() async {
    if (widget.isParagraph) {
      customQuestion =
          'Help me translate this paragraph to English: ${widget.word}';
    } else {
      customQuestion =
          'Help me translate this word: "${widget.word.trim()}" from Vietnamese to English: ${Properties.defaultSetting.dictionaryResponseSelectedList}. Please divide the answer into listed topics, and translate those topics into Vietnamese, ensuring that the English sentences are immediately followed by their Vietnamese translations. Any explanations within the answer must be in Vietnamese.';
    }
    var request = await widget.listChatGptRepository[widget.index]
        .createSingleQuestionRequest(customQuestion);
    return request;
  }
  @override
  void initState() {
    super.initState();
    _requestFuture = _getQuestionRequest();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: _requestFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ChatBotBubble(
            word: widget.word,
            chatListController: widget.chatListController,
            index: widget.index,
            listChatGptRepository: widget.listChatGptRepository,
            request: snapshot.data as ChatCompletionRequest,
          );
        } else {
          // Handle loading state or return a loading widget
          return const CircularProgressIndicator();
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
