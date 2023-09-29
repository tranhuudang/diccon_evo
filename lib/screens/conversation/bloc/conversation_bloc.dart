import 'dart:async';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/chatbot_buble.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/dictionary_buble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';
import '../../../config/properties.dart';
import '../../../data/data_providers/searching.dart';
import '../../../data/models/word.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../ui/components/brick_wall_buttons.dart';
import '../ui/components/image_buble.dart';

part 'conversation_state.dart';
part 'conversation_event.dart';

class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc()
      : super(ConversationInitial(conversation: [/*const WelcomeBox()*/])) {
    on<AddBotReply>(_addBotReply);
    on<AddUserMessage>(_addUserMessage);
  }
  final chatGptRepository = ChatGptRepository();
  List<Widget> conversation = [];

  void _addUserMessage(AddUserMessage event, Emitter<ConversationState> emit) {
    var word = Word(word: event.providedWord);
    conversation.add(DictionaryBubble(isMachine: false, message: word));
    emit(ConversationUpdated(conversation: conversation));
  }

  Future<void> _addBotReply(
      AddBotReply event, Emitter<ConversationState> emit) async {
    final question = event.providedWord;
    var request = await chatGptRepository.createQuestionRequest(question);
    var answerIndex = chatGptRepository.questionAnswers.length - 1;
    conversation.add(ChatbotBubble(
      questionRequest: request,
      chatGptRepository: chatGptRepository,
      answerIndex: answerIndex,
    ));
    emit(ConversationUpdated(conversation: conversation));
  }
}
