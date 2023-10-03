import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/commons/clickable_words.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:diccon_evo/screens/dictionary/bloc/chat_list_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotBubble extends StatefulWidget {
   const ChatbotBubble({
    Key? key,
    required this.questionRequest,
    this.onWordTap,
    required this.chatGptRepository,
    required this.answerIndex,
    required this.word,
     required this.chatListController,
  }) : super(key: key);

  final ChatCompletionRequest questionRequest;
  final Function(String)? onWordTap;
  final ChatGptRepository chatGptRepository;
  final int answerIndex;
  final String word;
  final ScrollController chatListController;

  @override
  State<ChatbotBubble> createState() => _ChatbotBubbleState();
}

class _ChatbotBubbleState extends State<ChatbotBubble>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  final isLoadingStreamController = StreamController<bool>();

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    isLoadingStreamController.sink.add(true);
    try {
      final stream = await widget.chatGptRepository.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              isLoadingStreamController.sink.add(false);
            } else {
              widget.chatListController.animateTo(
                widget.chatListController.position.maxScrollExtent, duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut, );
              return widget.chatGptRepository.questionAnswers.last.answer.write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        widget.chatGptRepository.questionAnswers.last.answer.write(
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
    if (widget.chatGptRepository.questionAnswers.isEmpty ||
        widget.chatGptRepository.questionAnswers[widget.answerIndex].answer
            .isEmpty) {
      _chatStreamResponse(widget.questionRequest);
    }
  }

  @override
  void dispose() {
    _chatStreamSubscription?.cancel();
    isLoadingStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionAnswer =
        widget.chatGptRepository.questionAnswers[widget.answerIndex];
    var answer = questionAnswer.answer.toString().trim();
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
                      stream: isLoadingStreamController.stream,
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            WordPlaybackButton(message: widget.word),
                            const Spacer(),
                            snapshot.data!
                                ? IconButton(
                                    onPressed: () {
                                      _chatStreamSubscription?.cancel();
                                      isLoadingStreamController.sink.add(false);
                                    },
                                    icon:
                                        const Icon(Icons.stop_circle_outlined))
                                : const SizedBox.shrink(),
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
                                      isLoadingStreamController.sink.add(true);
                                      widget
                                          .chatGptRepository
                                          .questionAnswers[widget.answerIndex]
                                          .answer
                                          .clear();
                                      _chatStreamResponse(
                                          widget.questionRequest);
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
