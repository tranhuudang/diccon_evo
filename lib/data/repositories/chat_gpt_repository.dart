import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import '../models/question_answer.dart';

class ChatGptRepository {
  /// Implement Chat Gpt
  final ChatGpt chatGpt =
      ChatGpt(apiKey: "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");
  final List<QuestionAnswer> questionAnswers = [];

  Future<ChatCompletionRequest> createQuestionRequest(
      String userQuestion) async {
    final question = userQuestion;
    questionAnswers.add(
      QuestionAnswer(
        question: question,
        answer: StringBuffer(),
      ),
    );
    final request = ChatCompletionRequest(
      stream: true,
      maxTokens: 4000,
      messages: [Message(role: Role.user.name, content: question)],
      model: ChatGptModel.gpt35Turbo,
    );
    return request;
  }
}
