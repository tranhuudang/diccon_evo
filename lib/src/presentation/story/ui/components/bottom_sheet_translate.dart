import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/foundation.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
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
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  final _isLoadingStreamController = StreamController();
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
              // Add translated paragraph to firebase
              _createFirebaseDatabaseItem();
              setState(() {});
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
      print("widget.message.word : ${widget.searchWord}");
    }
    var request = await _chatGptRepository.createSingleQuestionRequest(
            '  Translate the English word "[${widget.searchWord}]" in this sentence "[${widget.sentenceContainWord}]" to Vietnamese and provide the response in the following format:'
            ''
            '  Phiên âm: /[phonetic transcription]/'
            '  Định nghĩa: [definition in Vietnamese]'
            ''
            '  Dịch câu: [translated sentence in Vietnamese]');
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final docUser = FirebaseFirestore.instance.collection("Story_v2").doc(answer);
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

  Future<void> _createFirebaseDatabaseItem() async {
    final answerId = Md5Generator.composeMd5IdForStoryFirebaseDb(
        sentence: widget.sentenceContainWord + widget.searchWord);
    final databaseRow =
        FirebaseFirestore.instance.collection("Story_v2").doc(answerId);
    final json = {
      'question': widget.sentenceContainWord,
      'answer': _chatGptRepository.singleQuestionAnswer.answer.toString(),
    };
    await databaseRow.set(json);
  }

  @override
  void dispose() {
    super.dispose();
    _isLoadingStreamController.close();
    _chatStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final questionAnswer = _chatGptRepository.singleQuestionAnswer;
    var answer = questionAnswer.answer.toString().trim();
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
                    PlaybackButton(
                      message: widget.sentenceContainWord,
                      icon: Icon(
                        Icons.volume_up,
                        color: context.theme.colorScheme.onSecondaryContainer,
                      ),
                    ),
                    Text(
                      widget.sentenceContainWord,
                      style: context.theme.textTheme.titleMedium?.copyWith(
                          color: context.theme.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  answer,
                  style: context.theme.textTheme.titleMedium
                      ?.copyWith(color: context.theme.colorScheme.onSurface),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
