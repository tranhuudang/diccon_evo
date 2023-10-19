import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import '../models/question_answer.dart';

class ChatGptRepository {
  ChatGptRepository({required this.chatGpt});
  /// Implement Chat Gpt

  final ChatGpt chatGpt;
  List<QuestionAnswer> questionAnswers = [];
  QuestionAnswer singleQuestionAnswer = QuestionAnswer(question: '', answer: StringBuffer());

  // Using in conversation to understand multiple questions in a conversation
  Future<ChatCompletionRequest> createMultipleQuestionRequest(
      String userQuestion) async {
    final question = userQuestion;
    questionAnswers.add(
      QuestionAnswer(
        question: question,
        answer: StringBuffer(),
      ),
    );
    final List<Message> messages = createMessageListFromQuestionAnswers(questionAnswers);
    
    final request = ChatCompletionRequest(
      stream: true,
      maxTokens: 2000,
      messages: messages,
      model: ChatGptModel.gpt35Turbo,
      temperature: 0.8,
    );
    return request;
  }

  // Using in dictionary for single question per request
  Future<ChatCompletionRequest> createSingleQuestionRequest(
      String userQuestion) async {
    singleQuestionAnswer =
      QuestionAnswer(
        question: userQuestion,
        answer: StringBuffer(),
    );
    final request = ChatCompletionRequest(
      stream: true,
      maxTokens: 2000,
      messages: [Message(role: Role.user.name, content: singleQuestionAnswer.question)],
      model: ChatGptModel.gpt35Turbo,
      temperature: 0.3,
    );
    return request;
  }

  List<Message> createMessageListFromQuestionAnswers(List<QuestionAnswer> questionAnswers) {
    final List<Message> messages = [];

    for (var qa in questionAnswers) {
      // Add a user message for the question
      messages.add(Message(role: Role.user.name, content: qa.question));

      // Add a bot message for the answer
      messages.add(Message(role: Role.assistant.name, content: qa.answer.toString()));
    }

    return messages;
  }

  void reset(){
    questionAnswers.clear();
    singleQuestionAnswer = QuestionAnswer(question: '', answer: StringBuffer());
  }
}
