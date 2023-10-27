import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';

import '../../../../../common/data/data_providers/searching.dart';
import '../../../../../common/data/models/word.dart';
class BottomSheetTranslation extends StatefulWidget {
  final String searchWord;
  final Function(String)? onWordTap;
  const BottomSheetTranslation(
      {super.key, this.onWordTap, required this.searchWord});

  @override
  State<BottomSheetTranslation> createState() => _BottomSheetTranslationState();
}

class _BottomSheetTranslationState extends State<BottomSheetTranslation> {
  final _chatGptRepository = ChatGptRepository(
      chatGpt: ChatGpt(apiKey: PropertiesConstants.dictionaryKey));
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  final _isLoadingStreamController = StreamController();
  final _tabSwicherStreamController = StreamController<TranslationChoices>();
  Word _wordResult = Word.empty();
  bool _isLoading = true;

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
    _getLocalDefinition();

    _sendAndGetResponse();
  }

  _getLocalDefinition() async {
    _wordResult = await Searching.getDefinition(widget.searchWord);
    setState(() {
      _isLoading = false;
    });
  }

  _sendAndGetResponse() async {
    if (kDebugMode) {
      print("widget.message.word : ${widget.searchWord}");
    }
    var request = await _chatGptRepository
        .createSingleQuestionRequest("Nghĩa của từ ${widget.searchWord}");
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
    return _isLoading
        ? const Center(
            child: SizedBox(
                height: 50, width: 50, child: CircularProgressIndicator()),
          )
        : Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: StreamBuilder<TranslationChoices>(
                  initialData: TranslationChoices.classic,
                  stream: _tabSwicherStreamController.stream,
                  builder: (context, tabSwitcher) {
                    return Column(
                      children: [
                        SwitchTranslationBar(
                          selectedItemSet:
                              (Set<TranslationChoices> selectedItemSet) {
                            _tabSwicherStreamController
                                .add(selectedItemSet.first);
                          },
                        ),
                        if (tabSwitcher.data == TranslationChoices.classic)
                          Column(
                            children: [
                              Row(
                                children: [
                                  WordTitle(
                                    message: _wordResult,
                                    titleColor:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  WordPronunciation(message: _wordResult),
                                  WordPlaybackButton(
                                      buttonColor: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      message: _wordResult.word),
                                ],
                              ),
                              Row(
                                children: [
                                  WordMeaning(
                                    message: _wordResult,
                                    onWordTap: widget.onWordTap,
                                    highlightColor:
                                        Theme.of(context).colorScheme.onSurface,
                                    subColor: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(.8),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Text(
                                  answer,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface),
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
