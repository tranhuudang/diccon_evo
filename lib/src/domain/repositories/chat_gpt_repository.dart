import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import '../domain.dart';

abstract class ChatGptRepository {
  late ChatGpt chatGpt;
  List<QuestionAnswer> questionAnswers = [];
  QuestionAnswer singleQuestionAnswer =
      QuestionAnswer(question: '', answer: StringBuffer());
  Future<ChatCompletionRequest> createMultipleQuestionRequest(
      String userQuestion);
  Future<ChatCompletionRequest> createSingleQuestionRequest(
      String userQuestion);
  List<Message> createMessageListFromQuestionAnswers(
      List<QuestionAnswer> questionAnswers);
  void reset();
}
