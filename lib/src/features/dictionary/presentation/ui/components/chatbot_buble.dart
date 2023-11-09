import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatbotBubble extends StatefulWidget {
  const ChatbotBubble({
    super.key,
    this.onWordTap,
    required this.word,
    required this.chatListController,
    required this.index,
    required this.listChatGptRepository, this.isParagraph = false,
  });

  final Function(String)? onWordTap;
  final String word;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  final bool isParagraph;

  @override
  State<ChatbotBubble> createState() => _ChatbotBubbleState();
}

class _ChatbotBubbleState extends State<ChatbotBubble>
    with AutomaticKeepAliveClientMixin {
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;

  final _isLoadingStreamController = StreamController<bool>();
  var customQuestion = '';

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
              _createFirebaseDatabaseItem();
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

  Future<void> _createFirebaseDatabaseItem() async {
    final answerId = _composeMd5IdForFirebaseDb(
        word: widget.word,
        options: Properties.defaultSetting
            .dictionaryResponseSelectedList); // Generate the MD5 hash
    final databaseRow =
        FirebaseFirestore.instance.collection("Dictionary").doc(answerId);
    final json = {
      'answer': widget
          .listChatGptRepository[widget.index].singleQuestionAnswer.answer
          .toString(),
    };
    await databaseRow.set(json);
  }

  void _getGptResponse() async {
    if (widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .isEmpty) {
      var request = await _getQuestionRequest();
      // create md5 from question to compare to see if that md5 is already exist in database
      var answer = _composeMd5IdForFirebaseDb(
          word: widget.word,
          options: Properties.defaultSetting.dictionaryResponseSelectedList);
      final docUser =
          FirebaseFirestore.instance.collection("Dictionary").doc(answer);
      await docUser.get().then((snapshot) async {
        if (snapshot.exists) {
          widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
              .write(snapshot.data()?['answer'].toString());
          setState(() {});
        } else {
          _chatStreamResponse(request);
        }
      });
    }
  }

  String _composeMd5IdForFirebaseDb(
      {required String word, required String options}) {
    word = word.trim().toLowerCase();
    options = options.trim();
    var composeString = word + options;
    var bytes = utf8.encode(composeString);
    var resultMd5 = md5.convert(bytes);
    return resultMd5.toString();
  }

  // This function be used to resend the question to gpt to get new answer
  void _reGetGptResponse() async {
    widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .clear();
    var request = await _getQuestionRequest();
    _chatStreamResponse(request);
  }

  Future<ChatCompletionRequest> _getQuestionRequest() async {
    if (widget.isParagraph) {
      customQuestion =
      'Hãy giúp tôi dịch đoạn văn sau sang tiếng Việt: ${widget.word}';
    }
    else {
      customQuestion =
      'Hãy giúp tôi dịch chữ "${widget.word
          .trim()}" từ tiếng Anh sang tiếng Việt với các chủ đề lần lượt là: ${Properties
          .defaultSetting
          .dictionaryResponseSelectedList}. Hãy chia câu trả lời thành các chủ đề vừa liệt kê, và dịch sang tiếng Việt các chủ đề đó, bắt buộc phải dịch sang tiếng Việt những câu bằng tiếng Anh ngay sau từng câu tiếng Anh (ngay liền kề mỗi câu). Bất cứ sự giải thích nào trong câu trả lời đều phải dùng tiếng Việt';

    }
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
                    PlaybackButton(message: widget.word),
                    const Spacer(),
                    if (snapshot.data!)
                      IconButton(
                          onPressed: () {
                            // Cancel response
                            _chatStreamSubscription?.cancel();
                            _isLoadingStreamController.sink.add(false);
                          },
                          icon: Icon(Icons.stop_circle_outlined,
                              color: context.theme.colorScheme.onSecondary)),
                    const HorizontalSpacing.medium(),
                    snapshot.data!
                        ? Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              height: 15,
                              width: 15,
                              child: CircularProgressIndicator(
                                color: context.theme.colorScheme.onSecondary,
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
                              color: context.theme.colorScheme.onSecondary,
                            )),
                  ],
                );
              }),
          ClickableWords(
              style: context.theme.textTheme.titleMedium
                  ?.copyWith(color: context.theme.colorScheme.onSecondary),
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
