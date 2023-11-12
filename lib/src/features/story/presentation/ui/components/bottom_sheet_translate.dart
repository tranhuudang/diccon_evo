import 'dart:async';
import 'dart:convert';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

class BottomSheetTranslation extends StatefulWidget {
  final String searchWord;
  final Function(String)? onWordTap;
  final String sentenceContainWord;
  const BottomSheetTranslation(
      {super.key,
      this.onWordTap,
      required this.searchWord,
      required this.sentenceContainWord});

  @override
  State<BottomSheetTranslation> createState() => _BottomSheetTranslationState();
}

class _BottomSheetTranslationState extends State<BottomSheetTranslation> {
  final _chatGptRepository = ChatGptRepositoryImplement(
      chatGpt: ChatGpt(apiKey: PropertiesConstants.dictionaryKey));
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  final _isLoadingStreamController = StreamController();
  final _tabSwicherStreamController = StreamController<StoryTranslationChoices>();
  Word _wordResult = Word.empty();
  bool _isLoading = true;
  final _pageController = PageController();
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
              if (defaultTargetPlatform.isAndroid()) {
                _createFirebaseDatabaseItem();
              }
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
    DictionaryRepository searchingEngine = DictionaryRepositoryImpl();
    _wordResult = await searchingEngine.getDefinition(widget.searchWord);
    setState(() {
      _isLoading = false;
    });
  }

  _sendAndGetResponse() async {
    if (kDebugMode) {
      print("widget.message.word : ${widget.searchWord}");
    }
    var request = await _chatGptRepository.createSingleQuestionRequest(
        'Nghĩa của từ "${widget.searchWord}" trong câu "${widget.sentenceContainWord}" là gì ? Sau đó xuống dòng và dịch hết câu văn đó (Lưu ý: chỉ dịch và không giải thích gì thêm).');
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = _composeMd5IdForFirebaseDb(
        word: widget.searchWord, options: widget.sentenceContainWord);
    final docUser =
        FirebaseFirestore.instance.collection("Story").doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        _chatGptRepository.singleQuestionAnswer.answer
            .write(snapshot.data()?['answer'].toString());
        setState(() {});
      } else {
        _chatStreamResponse(request);
      }
    });
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

  Future<void> _createFirebaseDatabaseItem() async {
    final answerId = _composeMd5IdForFirebaseDb(
        word: widget.searchWord, options: widget.sentenceContainWord);
    final databaseRow =
        FirebaseFirestore.instance.collection("Story").doc(answerId);
    final json = {
      'answer': _chatGptRepository.singleQuestionAnswer.answer.toString(),
    };
    await databaseRow.set(json);
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
                child: StreamBuilder<StoryTranslationChoices>(
                  initialData: StoryTranslationChoices.translate,
                  stream: _tabSwicherStreamController.stream,
                  builder: (context, tabSwitcher) {
                    return Column(
                      children: [
                        SwitchTranslationBar(
                          currentValue: tabSwitcher.data,
                          selectedItemSet:
                              (Set<StoryTranslationChoices> selectedItemSet) {
                            _tabSwicherStreamController
                                .add(selectedItemSet.first);
                            if (selectedItemSet.first ==
                                StoryTranslationChoices.translate) {
                              _pageController.previousPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                            if (selectedItemSet.first ==
                                StoryTranslationChoices.explain) {
                              _pageController.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          },
                        ),
                        ExpandablePageView(
                          controller: _pageController,
                          onPageChanged: (index) {
                            if (index == 0) {
                              _tabSwicherStreamController
                                  .add(StoryTranslationChoices.translate);
                            }
                            if (index == 1) {
                              _tabSwicherStreamController
                                  .add(StoryTranslationChoices.explain);
                            }
                          },
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    WordTitle(
                                      message: _wordResult,
                                      titleColor:
                                          context.theme.colorScheme.onSurface,
                                    ),
                                    const SizedBox(
                                      width: 8.0,
                                    ),
                                    WordPronunciation(message: _wordResult),
                                    PlaybackButton(
                                        buttonColor:
                                            context.theme.colorScheme.onSurface,
                                        message: _wordResult.word),
                                  ],
                                ),
                                Row(
                                  children: [
                                    WordMeaning(
                                      message: _wordResult,
                                      onWordTap: widget.onWordTap,
                                      highlightColor:
                                          context.theme.colorScheme.onSurface,
                                      subColor: context
                                          .theme.colorScheme.onSurface
                                          .withOpacity(.8),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 16),
                                  child: Text(
                                    widget.sentenceContainWord,
                                    style: context.theme.textTheme.titleMedium
                                        ?.copyWith(
                                        color: context
                                            .theme.colorScheme.onSurface),
                                  ),
                                )
                                ,
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: Text(
                                    answer,
                                    style: context.theme.textTheme.titleMedium
                                        ?.copyWith(
                                            color: context
                                                .theme.colorScheme.onSurface),
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
  }
}
