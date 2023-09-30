import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/foundation.dart';
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
    var listMessage = _createListMessage();
    final request = ChatCompletionRequest(
      stream: true,
      maxTokens: 2000,
      //messages: [Message(role: Role.user.name, content: question)],
      messages: listMessage,
      model: ChatGptModel.gpt35Turbo,
      temperature: 0.5,
    );
    return request;
  }
  List<Message> _createListMessage(){
    List<Message> listMessage = [];

     for(var i = 0; i< questionAnswers.length; i++){
      if(i == 0 || i%2 == 0) {
        listMessage.add(Message(role: Role.user.name, content: questionAnswers[i].question));
        if (kDebugMode) {
          print("user : ${questionAnswers[i].question}");
        }
      } else {
        listMessage.add(Message(role: Role.assistant.name, content: questionAnswers[i].answer.toString()));
        if (kDebugMode) {
          print("assistant: ${questionAnswers[i].answer.toString()}");
        }
      }
    }

    return listMessage;
  }
}
