import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/commons/word_meaning.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:diccon_evo/screens/commons/word_pronunciation.dart';
import 'package:diccon_evo/screens/commons/word_title.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/translation_choices.dart';
import '../../../../data/models/word.dart';
import '../../../commons/switch_translation_bar.dart';

class BottomSheetTranslation extends StatefulWidget {
  final Word message;
  final Function(String)? onWordTap;
  const BottomSheetTranslation(
      {super.key, required this.message, this.onWordTap});

  @override
  State<BottomSheetTranslation> createState() => _BottomSheetTranslationState();
}

class _BottomSheetTranslationState extends State<BottomSheetTranslation> {
  final _chatGptRepository = ChatGptRepository();
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  final _isLoadingStreamController = StreamController();
  final _tabSwicherStreamController = StreamController<TranslationChoices>();

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream =
          await _chatGptRepository.chatGpt.createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
        (event) => setState(
          () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              _isLoadingStreamController.sink.add(false);
            } else {
              return _chatGptRepository.singleQuestionAnswer.answer.write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        _chatGptRepository.singleQuestionAnswer.answer.write(
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
    _sendAndGetResponse();
  }

  _sendAndGetResponse() async {
    if (kDebugMode) {
      print("widget.message.word : ${widget.message.word}");
    }
    var request = await _chatGptRepository
        .createSingleQuestionRequest("Nghĩa của từ ${widget.message.word}");
    _chatStreamResponse(request);
  }

  @override
  void dispose() {
    super.dispose();
    _tabSwicherStreamController.close();
    _isLoadingStreamController.close();
    _chatStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final questionAnswer = _chatGptRepository.singleQuestionAnswer;
    var answer = questionAnswer.answer.toString().trim();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<TranslationChoices>(
            initialData: TranslationChoices.classic,
            stream: _tabSwicherStreamController.stream,
            builder: (context, tabSwitcher) {
              return Column(
                children: [
                  SwitchTranslationBar(
                    selectedItemSet: (Set<TranslationChoices> selectedItemSet) {
                      _tabSwicherStreamController.add(selectedItemSet.first);
                    },
                  ),
                  if (tabSwitcher.data == TranslationChoices.classic)
                    Column(
                      children: [
                        Row(
                          children: [
                            WordTitle(
                              message: widget.message,
                              titleColor: Colors.white,
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            WordPronunciation(message: widget.message),
                            WordPlaybackButton(message: widget.message.word),
                          ],
                        ),
                        Row(
                          children: [
                            WordMeaning(
                              message: widget.message,
                              onWordTap: widget.onWordTap,
                              highlightColor: Colors.white,
                              subColor: Colors.white70,
                            ),
                          ],
                        ),
                      ],
                    ),
                  if (tabSwitcher.data == TranslationChoices.ai) ...[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            answer,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                          ),
                        )
                      ],
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
