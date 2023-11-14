import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/features/dictionary/presentation/ui/components/chatbot_buble.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

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
          'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: ${widget.word}';
    } else {
      customQuestion =
          'Hãy giúp tôi dịch chữ "${widget.word.trim()}" từ tiếng Anh sang tiếng Việt với các chủ đề lần lượt là: ${Properties.defaultSetting.dictionaryResponseSelectedList}. Hãy chia câu trả lời thành các chủ đề vừa liệt kê, và dịch sang tiếng Việt các chủ đề đó, bắt buộc phải dịch sang tiếng Việt những câu bằng tiếng Anh ngay sau từng câu tiếng Anh (ngay liền kề mỗi câu). Bất cứ sự giải thích nào trong câu trả lời đều phải dùng tiếng Việt';
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
