import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/core/core.dart';
import '../../../../domain/domain.dart';
import '../../../presentation.dart';

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
          InAppStrings.getViToEnParagraphTranslateQuestion(widget.word);
    } else {
      customQuestion =
          InAppStrings.getViToEnSingleWordTranslateQuestion(widget.word);
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
            lang: "vi to en",
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
