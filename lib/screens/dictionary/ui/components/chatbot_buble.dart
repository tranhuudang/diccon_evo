import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/clickable_words.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:diccon_evo/screens/dictionary/bloc/dictionary_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/properties.dart';

class ChatbotBubble extends StatefulWidget {
  const ChatbotBubble({
    Key? key,
    this.onWordTap,
    required this.word,
    required this.chatListController,
    required this.index,
    required this.listChatGptRepository,
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
      final stream = await widget.listChatGptRepository[widget.index].chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              _isLoadingStreamController.sink.add(false);
            } else {
              return widget.listChatGptRepository[widget.index]
                  .singleQuestionAnswer.answer
                  .write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
            .write(
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
    if (widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .isEmpty) {
      var request = await _getQuestionRequest();
      _chatStreamResponse(request);
    }
  }

  // This function be used to resend the question to gpt to get new answer
  void _reGetGptResponse() async {
    widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .clear();
    var request = await _getQuestionRequest();
    _chatStreamResponse(request);
  }

  Future<ChatCompletionRequest> _getQuestionRequest() async {
    var customQuestion =
        'Hãy giúp tôi dịch chữ "${widget.word}" từ tiếng Anh sang tiếng Việt với các chủ đề lần lượt là: ${Properties.defaultSetting.dictionaryResponseSelectedList}. Hãy chia câu trả lời thành các chủ đề, và dịch sang tiếng Việt các chủ đề đó, bắt buộc phải dịch sang tiếng Việt những câu bằng tiếng Anh ngay sau từng câu tiếng Anh (ngay liền kề mỗi câu). Bất cứ sự giải thích nào trong câu trả lời đều phải dùng tiếng Việt';
    var request = await widget.listChatGptRepository[widget.index]
        .createSingleQuestionRequest(customQuestion);
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
    var answer = widget
        .listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .toString()
        .trim();
    final chatListBloc = context.read<ChatListBloc>();
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
                    if (snapshot.data!)
                      IconButton(
                          onPressed: () {
                            // Cancel response
                            _chatStreamSubscription?.cancel();
                            _isLoadingStreamController.sink.add(false);
                          },
                          icon: Icon(Icons.stop_circle_outlined,
                              color:
                                  Theme.of(context).colorScheme.onSecondary)),
                    const SizedBox().mediumWidth(),
                    snapshot.data!
                        ? Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              // resend the request to get new answer
                              _isLoadingStreamController.sink.add(true);
                              _reGetGptResponse();
                            },
                            icon: Icon(
                              Icons.cached_rounded,
                              color: Theme.of(context).colorScheme.onSecondary,
                            )),
                  ],
                );
              }),
          ClickableWords(
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onSecondary),
              onWordTap: (word) {
                chatListBloc.add(AddUserMessage(providedWord: word));
                chatListBloc.add(AddTranslation(providedWord: word));
              },
              text: answer)
          // SelectableText(
          //     answer),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
