import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChatbotBubble extends StatefulWidget {
  const ChatbotBubble({
    Key? key,
    required this.questionRequest,
    this.onWordTap,
    required this.chatGptRepository,
    required this.answerIndex,
  }) : super(key: key);

  final ChatCompletionRequest questionRequest;
  final Function(String)? onWordTap;
  final ChatGptRepository chatGptRepository;
  final int answerIndex;

  @override
  State<ChatbotBubble> createState() => _ChatbotBubbleState();
}

class _ChatbotBubbleState extends State<ChatbotBubble>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  /// End implement Chat Gpt

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    try {
      final stream = await widget.chatGptRepository.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
            } else {
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

  _chatStreamResponseReload(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    try {
      final stream = await widget.chatGptRepository.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
            (event) => setState(
              () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
            } else {
              return widget.chatGptRepository.questionAnswers[widget.answerIndex].answer.write(
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
    if (widget
        .chatGptRepository.questionAnswers[widget.answerIndex].answer.isEmpty) {
      _chatStreamResponse(widget.questionRequest);
    }
  }

  @override
  void dispose() {
    _chatStreamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final questionAnswer =
        widget.chatGptRepository.questionAnswers[widget.answerIndex];
    var answer = questionAnswer.answer.toString().trim();
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
                children: [
                  Row(children: [
                    WordPlaybackButton(message: "message"),
                    Spacer(),
                    IconButton(onPressed: (){
                      setState(() {
                        answer ="";
                      });
                      _chatStreamResponseReload(widget.questionRequest);
                    }, icon: Icon(Icons.cached_rounded)),
                  ],),
                  Text(answer),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
