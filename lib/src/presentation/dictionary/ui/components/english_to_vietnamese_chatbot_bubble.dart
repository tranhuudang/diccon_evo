import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/core/constants/constants.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';

class EnglishToVietnameseChatBotBubble extends StatefulWidget {
  const EnglishToVietnameseChatBotBubble({
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
  State<EnglishToVietnameseChatBotBubble> createState() =>
      _EnglishToVietnameseChatBotBubbleState();
}

class _EnglishToVietnameseChatBotBubbleState
    extends State<EnglishToVietnameseChatBotBubble>
    with AutomaticKeepAliveClientMixin {
  var customQuestion = '';
  late Future<ChatCompletionRequest> _requestFuture;

  Future<ChatCompletionRequest> _getQuestionRequest() async {
    if (widget.isParagraph) {
      customQuestion =
          InAppStrings.getEnToViParagraphTranslateQuestion(widget.word);
    } else {
      customQuestion =
          InAppStrings.getEnToViSingleWordTranslateQuestion(widget.word);
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
            lang: "en to vi",
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
