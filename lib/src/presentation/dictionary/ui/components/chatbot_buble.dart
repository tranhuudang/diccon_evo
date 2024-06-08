import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/domain.dart';

class ChatBotBubble extends StatefulWidget {
  const ChatBotBubble({
    super.key,
    this.onWordTap,
    required this.word,
    required this.chatListController,
    required this.index,
    required this.listChatGptRepository,
    this.isParagraph = false,
    required this.request, required this.lang,
  });

  final Function(String)? onWordTap;
  final String word;
  final String lang;
  final ScrollController chatListController;
  final int index;
  final List<ChatGptRepository> listChatGptRepository;
  final bool isParagraph;
  final ChatCompletionRequest request;

  @override
  State<ChatBotBubble> createState() => _ChatBotBubbleState();
}

class _ChatBotBubbleState extends State<ChatBotBubble>
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
              // Only add definition of a word to firebase database when it not a paragraph

              if (!widget.isParagraph) {
                _createFirebaseDatabaseItem();
              }
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
    final currentSettings = Properties.instance.settings;
    final answerId = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
        lang: widget.lang,
        word: widget.word,
        options: currentSettings
            .dictionaryResponseSelectedListVietnamese); // Generate the MD5 hash
    final databaseRow =
        FirebaseFirestore.instance.collection("Dictionary_v2").doc(answerId);
    final json = {
      'question': widget.word,
      'answer': widget
          .listChatGptRepository[widget.index].singleQuestionAnswer.answer
          .toString(),
    };
    await databaseRow.set(json);
  }

  void _getGptResponse() async {
    final currentSettings = Properties.instance.settings;
    if (widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .isEmpty) {
      var request = widget.request;
      // create md5 from question to compare to see if that md5 is already exist in database
      var answer = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
          lang: widget.lang,
          word: widget.word,
          options: currentSettings.dictionaryResponseSelectedListVietnamese);
      final docUser =
          FirebaseFirestore.instance.collection("Dictionary_v2").doc(answer);
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

  // This function be used to resend the question to gpt to get new answer
  void _reGetGptResponse() async {
    widget.listChatGptRepository[widget.index].singleQuestionAnswer.answer
        .clear();
    var request = widget.request;
    _chatStreamResponse(request);
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
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StreamBuilder<bool>(
              initialData: false,
              stream: _isLoadingStreamController.stream,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    //PlaybackButton(message: widget.word),
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
                    8.width,
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
              style: context.theme.textTheme.bodyMedium
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
