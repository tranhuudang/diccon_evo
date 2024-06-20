import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../../data/data.dart';

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
  final _chatGptRepository =
      ChatGptRepositoryImplement(chatGpt: ChatGpt(apiKey: ApiKeys.openAiKey));
  final _chatGptRepositoryForSentence =
      ChatGptRepositoryImplement(chatGpt: ChatGpt(apiKey: ApiKeys.openAiKey));
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  StreamSubscription<StreamCompletionResponse>?
      _chatStreamSubscriptionForSentence;
  final _isLoadingStreamController = StreamController();
  bool _isEditing = false;
  bool _isEditor = false;

  final TextEditingController _editingController = TextEditingController();
  final TextEditingController _editingControllerForSentence = TextEditingController();

  Future<void> _checkIfUserIsEditor() async {
    final authUser = FirebaseAuth.instance.currentUser;
    final userId = Md5Generator.composeMd5IdForFirebaseDbPremium(
        userEmail: authUser?.email ?? '');
    final editorDoc =
        await FirebaseFirestore.instance.collection(FirebaseConstant.firestore.editor).doc(userId).get();

    setState(() {
      _isEditor = editorDoc.exists;
    });
  }

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream =
          await _chatGptRepository.chatGpt.createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen((event) => setState(() {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              _isLoadingStreamController.sink.add(false);
              // Add translated paragraph to firebase
              _createFirebaseDatabaseItemForWord();
              setState(() {});
            } else {
              return _chatGptRepository.singleQuestionAnswer.answer
                  .write(event.choices?.first.delta?.content);
            }
          }));
    } catch (error) {
      setState(() {
        _chatGptRepository.singleQuestionAnswer.answer.write("");
      });
      if (kDebugMode) {
        print("Error occurred: $error");
      }
    }
  }

  _chatStreamResponseForSentence(ChatCompletionRequest request) async {
    _chatStreamSubscriptionForSentence?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream = await _chatGptRepositoryForSentence.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscriptionForSentence =
          stream?.listen((event) => setState(() {
                if (event.streamMessageEnd) {
                  _chatStreamSubscriptionForSentence?.cancel();
                  _isLoadingStreamController.sink.add(false);
                  // Add translated paragraph to firebase
                  _createFirebaseDatabaseItemForSentence();
                  setState(() {});
                } else {
                  return _chatGptRepositoryForSentence
                      .singleQuestionAnswer.answer
                      .write(event.choices?.first.delta?.content);
                }
              }));
    } catch (error) {
      setState(() {
        _chatGptRepositoryForSentence.singleQuestionAnswer.answer.write("");
      });
      if (kDebugMode) {
        print("Error occurred: $error");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _checkIfUserIsEditor();
    _sendAndGetResponse();
  }

  _sendAndGetResponse() async {
    await _sendAndGetResponseForWord();
    await _sendAndGetResponseForSentence();
  }

  _sendAndGetResponseForWord() async {
    var request = await _chatGptRepository.createSingleQuestionRequest(
        '  Translate the English word "[${widget.searchWord}]" in this sentence "[${widget.sentenceContainWord}]" context to Vietnamese and provide the response in the following format:'
        ''
        '  Phiên âm: /[phonetic transcription in English]/'
        '  Định nghĩa: [definition in Vietnamese]'
        '');
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final docUser =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answer);
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

  _sendAndGetResponseForSentence() async {
    var request = await _chatGptRepositoryForSentence.createSingleQuestionRequest(
        '  Translate the English sentence "[${widget.sentenceContainWord}]" to Vietnamese and provide the response in the following format:'
        ''
        ' Dịch câu: [translated sentence in Vietnamese]'
        '');
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord);
    final docUser =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answer);
    await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        _chatGptRepositoryForSentence.singleQuestionAnswer.answer
            .write(snapshot.data()?['answer'].toString());
        setState(() {});
      } else {
        _chatStreamResponseForSentence(request);
      }
    });
  }

  Future<void> _createFirebaseDatabaseItemForWord() async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final databaseRow =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answerId);
    final json = {
      'question':
          "${widget.searchWord}- in the sentence: ${widget.sentenceContainWord}",
      'answer': _chatGptRepository.singleQuestionAnswer.answer.toString(),
    };
    await databaseRow.set(json);
  }

  Future<void> _createFirebaseDatabaseItemForSentence() async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord);
    final databaseRow =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answerId);
    final json = {
      'question': widget.sentenceContainWord,
      'answer':
          _chatGptRepositoryForSentence.singleQuestionAnswer.answer.toString(),
    };
    await databaseRow.set(json);
  }

  Future<void> _updateFirebaseDatabaseItem(String newAnswer) async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final databaseRow =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answerId);
    final json = {
      'question':
          "${widget.searchWord}- in the sentence: ${widget.sentenceContainWord}",
      'answer': newAnswer,
    };
    await databaseRow.update(json);
  }

  Future<void> _updateFirebaseDatabaseItemForSentence(String newAnswer) async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord);
    final databaseRow =
        FirebaseFirestore.instance.collection(FirebaseConstant.firestore.story).doc(answerId);
    final json = {
      'question': widget.sentenceContainWord,
      'answer': newAnswer,
    };
    await databaseRow.set(json);
  }

  List<Widget> _highlightWord(String text, String wordToHighlight) {
    List<Widget> spans = [];
    final wordToHighlightRefined =
        wordToHighlight.trim().toLowerCase().removeSpecialCharacters();
    final words = text.split(' ');

    for (final word in words) {
      String wordInSentence =
          word.trim().toLowerCase().removeSpecialCharacters();
      if (wordInSentence == wordToHighlightRefined) {
        spans.add(
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 2.0), // Adjust margin to control spacing
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                word,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: context.theme.colorScheme.onPrimary),
              ),
            ),
          ),
        );
      } else {
        spans.add(
          Text(
            '$word ',
            style: context.theme.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSurface.withOpacity(.5)),
          ),
        );
      }
    }

    return spans;
  }

  @override
  void dispose() {
    super.dispose();
    _isLoadingStreamController.close();
    _chatStreamSubscription?.cancel();
    _chatStreamSubscriptionForSentence?.cancel();
    _editingController.dispose();
    _editingControllerForSentence.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionAnswer = _chatGptRepository.singleQuestionAnswer;
    final questionAnswerForSentence =
        _chatGptRepositoryForSentence.singleQuestionAnswer;
    var answer = questionAnswer.answer
        .toString()
        .trim()
        .replaceAll('[', '')
        .replaceAll(']', '');
    var answerForSentence = questionAnswerForSentence.answer
        .toString()
        .trim()
        .replaceAll('[', '')
        .replaceAll(']', '');

    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isEditing) ...[
                      32.height,
                      Text(
                        'Editor Mode',
                        style: context.theme.textTheme.titleMedium,
                      ),
                      const WaveDivider(
                        thickness: .3,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ],
                    Row(
                      children: [
                        Row(
                          children: [
                            Text(widget.searchWord.upperCaseFirstLetter()),
                            PlaybackButton(
                              message: widget.searchWord,
                              icon: Icon(
                                Icons.volume_up,
                                color: context
                                    .theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                        Text("|",
                            style: TextStyle(
                                color: context.theme.colorScheme.onSurface
                                    .withOpacity(.5))),
                        16.width,
                        Row(
                          children: [
                            Text('All'.i18n),
                            PlaybackButton(
                              message: widget.sentenceContainWord,
                              icon: Icon(
                                Icons.volume_up,
                                color: context
                                    .theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Wrap(
                      children: _highlightWord(
                          widget.sentenceContainWord, widget.searchWord),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: _isEditing
                    ? Column(
                        children: [
                          TextField(
                            controller: _editingController,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Edit Answer',
                            ),
                          ),
                          16.height,
                          TextField(
                            controller: _editingControllerForSentence,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Edit Answer For Sentence',
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                },
                                child: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isEditing = false;
                                  });
                                  answer = _editingController.text.trim();
                                  _updateFirebaseDatabaseItem(answer);
                                  answerForSentence =
                                      _editingControllerForSentence.text.trim();
                                  _updateFirebaseDatabaseItemForSentence(
                                      answerForSentence);
                                },
                                child: const Text('Save'),
                              ),
                            ],
                          ),
                          300.height,
                        ],
                      )
                    : Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  answer,
                                  style: context.theme.textTheme.titleMedium
                                      ?.copyWith(
                                          color: context
                                              .theme.colorScheme.onSurface),
                                ),
                                Text(
                                  answerForSentence,
                                  style: context.theme.textTheme.titleMedium
                                      ?.copyWith(
                                          color: context
                                              .theme.colorScheme.onSurface),
                                ),
                              ],
                            ),
                          ),
                          if (_isEditor)
                            Column(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    _editingController.text = answer;
                                    _editingControllerForSentence.text =
                                        answerForSentence;
                                    setState(() {
                                      _isEditing = true;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
