import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ConversationMachineBubble extends StatefulWidget {
  const ConversationMachineBubble({
    Key? key,
    required this.questionRequest,
    this.onWordTap,
    required this.chatGptRepository,
    required this.answerIndex,
    required this.conversationScrollController,
  }) : super(key: key);

  final ChatCompletionRequest questionRequest;
  final Function(String)? onWordTap;
  final ChatGptRepository chatGptRepository;
  final int answerIndex;
  final ScrollController conversationScrollController;

  @override
  State<ConversationMachineBubble> createState() =>
      _ConversationMachineBubbleState();
}

class _ConversationMachineBubbleState extends State<ConversationMachineBubble>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  final _isLoadingStreamController = StreamController<bool>();

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream = await widget.chatGptRepository.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              _isLoadingStreamController.sink.add(false);
            } else {
              _scrollToBottom();
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

  void _scrollToBottom() {
    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      widget.conversationScrollController.animateTo(
        widget.conversationScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget
        .chatGptRepository.questionAnswers[widget.answerIndex].answer.isEmpty) {
      _chatStreamResponse(widget.questionRequest);
    }
  }

  @override
  void dispose() {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionAnswer =
        widget.chatGptRepository.questionAnswers[widget.answerIndex];
    var answer = questionAnswer.answer.toString().trim();
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 8, 16, 8),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              StreamBuilder<bool>(
                  initialData: false,
                  stream: _isLoadingStreamController.stream,
                  builder: (context, snapshot) {
                    return Row(
                      children: [
                        const Spacer(),
                        if (snapshot.data!)
                          IconButton(
                              onPressed: () {
                                _chatStreamSubscription?.cancel();
                                _isLoadingStreamController.sink.add(false);
                              },
                              icon: Icon(
                                Icons.stop_circle_outlined,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              )),
                        snapshot.data!
                            ? Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  height: 15,
                                  width: 15,
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ),
                              )
                            : IconButton(
                                onPressed: () {
                                  _isLoadingStreamController.sink.add(true);
                                  widget
                                      .chatGptRepository
                                      .questionAnswers[widget.answerIndex]
                                      .answer
                                      .clear();
                                  _chatStreamResponse(widget.questionRequest);
                                },
                                icon: Icon(
                                  Icons.cached_rounded,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                )),
                      ],
                    );
                  }),
              Align(
                alignment: Alignment.topLeft,
                child: SelectableText(
                  answer,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
