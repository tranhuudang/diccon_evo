import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/conversation/ui/components/conversation_welcome_box.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../../../config/properties_constants.dart';
import '../../commons/no_internet_buble.dart';
import '../ui/components/conversation_machine_bubble.dart';
import '../ui/components/conversation_user_bubble.dart';

/// Events
@immutable
abstract class ConversationEvent {}

class AskAQuestion extends ConversationEvent {
  final String providedWord;
  AskAQuestion({required this.providedWord});
}

class ResetConversation extends ConversationEvent {}

/// State
abstract class ConversationState {}

abstract class ConversationActionState extends ConversationState {}

class ConversationInitial extends ConversationState {
  List<Widget> conversation;
  ConversationInitial({required this.conversation});
}

class ConversationUpdated extends ConversationState {
  List<Widget> conversation;
  ConversationUpdated({required this.conversation});
}

/// Bloc
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc()
      : super(
            ConversationInitial(conversation: [const ConversationWelcome()])) {
    on<AskAQuestion>(_addUserMessage);
    on<ResetConversation>(_resetConversation);
  }

  final chatGptRepository = ChatGptRepository(chatGpt: ChatGpt(apiKey: PropertiesConstants.conversationKey));
  List<Widget> listConversations = [const ConversationWelcome()];
  final ScrollController conversationScrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  bool isReportedAboutDisconnection = false;

  Future<void> _addUserMessage(
      AskAQuestion event, Emitter<ConversationState> emit) async {
    listConversations.add(ConversationUserBubble(
      message: event.providedWord,
      onTap: () {
        textController.text = event.providedWord;
      },
    ));
    textController.clear();
    emit(ConversationUpdated(conversation: listConversations));
    _scrollToBottom();
    // Check internet connection before create request to chatbot
    bool isInternetConnected = await InternetConnectionChecker().hasConnection;
    if (kDebugMode) {
      print("[Internet Connection] $isInternetConnected");
    }
    if (!isInternetConnected) {
      listConversations.add(const NoInternetBubble());
      emit(ConversationUpdated(conversation: listConversations));
      isReportedAboutDisconnection = true;
    } else {
      /// Process and return reply
      final question = event.providedWord;
      // create gpt request
      var request =
          await chatGptRepository.createMultipleQuestionRequest(question);
      var answerIndex = chatGptRepository.questionAnswers.length - 1;
      listConversations.add(ConversationMachineBubble(
        questionRequest: request,
        chatGptRepository: chatGptRepository,
        answerIndex: answerIndex,
        conversationScrollController: conversationScrollController,
      ));
      emit(ConversationUpdated(conversation: listConversations));
      _scrollToBottom();
    }
  }

  FutureOr<void> _resetConversation(
      ResetConversation event, Emitter<ConversationState> emit) {
    chatGptRepository.reset();
    listConversations = [const ConversationWelcome()];
    emit(ConversationUpdated(conversation: listConversations));
  }

  void _scrollToBottom() {
    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      conversationScrollController.animateTo(
        conversationScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
