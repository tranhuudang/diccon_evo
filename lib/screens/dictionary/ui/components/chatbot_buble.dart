import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/clickable_words.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:diccon_evo/screens/dictionary/bloc/chat_list_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/properties.dart';
import '../../../../data/models/dictionary_response_type.dart';

class ChatbotBubble extends StatefulWidget {
  const ChatbotBubble({
    Key? key,
    this.onWordTap,
    required this.word,
    required this.chatListController, required this.index, required this.listChatGptRepository,
  }) : super(key: key);

  final Function(String)? onWordTap;
  final String word;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;

  @override
  State<ChatbotBubble> createState() => _ChatbotBubbleState();
}

class _ChatbotBubbleState extends State<ChatbotBubble>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  final _isLoadingStreamController = StreamController<bool>();

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream =
          await widget.listChatGptRepository[widget.index].chatGpt.createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              _isLoadingStreamController.sink.add(false);
            } else {
              Future.delayed(const Duration(milliseconds: 300), () {
                widget.chatListController.animateTo(
                  widget.chatListController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
              });
              return widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer.write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer.write(
            "Error: The Diccon server is currently overloaded due to a high number of concurrent users.");
      });
      if (kDebugMode) {
        print("Error occurred: $error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getGptResponse();
  }

  void _getGptResponse() async {
    if (widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer.isEmpty) {
      var request = await _getQuestionRequest();
      _chatStreamResponse(request);
    }
  }

  // This function be used to resend the question to gpt to get new answer
  void _reGetGptResponse() async {
    widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer.clear();
      var request = await _getQuestionRequest();
      _chatStreamResponse(request);
  }

  Future<ChatCompletionRequest> _getQuestionRequest() async {
    var question = '';
    switch (Properties.dictionaryResponseType) {
      case DictionaryResponseType.shortWithOutPronunciation:
        question = 'Giải thích ngắn gọn từ "${widget.word}" nghĩa là gì?';
        break;
      case DictionaryResponseType.short:
        question =
            'Viết một dòng về phiên âm của từ "${widget.word}". Bên dưới giải thích ngắn gọn từ "${widget.word}" nghĩa là gì?';
        break;
      case DictionaryResponseType.normal:
        question =
            'Phiên âm của từ "${widget.word}", nghĩa của từ "${widget.word}" và ví dụ khi sử dụng từ "${widget.word}" trong tiếng Anh kèm bản dịch.';
        break;
      case DictionaryResponseType.normalWithOutExample:
        question =
            'Viết cho tôi một dòng về phiên âm của từ "${widget.word}", sau đó giải thích về nghĩa của từ "${widget.word}"?';
        break;
      case DictionaryResponseType.normalWithOutPronunciation:
        question =
            'Giải thích nghĩa của từ "${widget.word}" và cho ví dụ tiếng Anh cùng với bản dịch tiếng Việt ở bên dưới.';
        break;
      default:
        question = 'Giải thích ngắn gọn từ "${widget.word}" nghĩa là gì?';
        break;
    }
    var request = await widget.listChatGptRepository[widget.index].createSingleQuestionRequest(question);
    return request;
  }

  @override
  void dispose() {
    super.dispose();
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var answer =
    widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer.toString().trim();
    final chatListBloc = context.read<ChatListBloc>();
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
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<bool>(
                      initialData: false,
                      stream: _isLoadingStreamController.stream,
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            WordPlaybackButton(message: widget.word),
                            const Spacer(),
                            snapshot.data!
                                ? IconButton(
                                    onPressed: () {
                                      // Cancel response
                                      _chatStreamSubscription?.cancel();
                                      _isLoadingStreamController.sink
                                          .add(false);
                                    },
                                    icon:
                                        const Icon(Icons.stop_circle_outlined))
                                : const SizedBox.shrink(),
                            const SizedBox().mediumWidth(),
                            snapshot.data!
                                ? const Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () {
                                      // resend the request to get new answer
                                      _isLoadingStreamController.sink.add(true);
                                      _reGetGptResponse();
                                    },
                                    icon: const Icon(Icons.cached_rounded)),
                          ],
                        );
                      }),
                  ClickableWords(
                      onWordTap: (word) {
                        chatListBloc.add(AddUserMessage(providedWord: word));
                        chatListBloc
                            .add(AddLocalTranslation(providedWord: word));
                      },
                      text: answer)
                  // SelectableText(
                  //     answer),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
