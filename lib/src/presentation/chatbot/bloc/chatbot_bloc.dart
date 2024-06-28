import 'dart:async';
import 'dart:io';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

/// Events
@immutable
abstract class ChatbotEvent {}

class AskAQuestion extends ChatbotEvent {
  final String providedWord;
  AskAQuestion({required this.providedWord});
}

class AnsweringAQuestion extends ChatbotEvent {
  final String answer;
  AnsweringAQuestion({required this.answer});
}

class ResetConversation extends ChatbotEvent {}

class StopResponse extends ChatbotEvent {}

class GoToUpgradeScreenEvent extends ChatbotEvent {}

/// State
abstract class ChatbotState {}

abstract class ChatbotActionState extends ChatbotState {}

class NotHaveEnoughToken extends ChatbotActionState {}

class GoToUpgradeScreen extends ChatbotActionState {}

class RequiredLogIn extends ChatbotActionState {}

class ChatbotInitial extends ChatbotState {
  List<Widget> conversation;
  ChatbotInitial({required this.conversation});
}

class ChatbotUpdated extends ChatbotState {
  List<Widget> conversation;
  bool isResponding;
  ChatbotUpdated({required this.conversation, required this.isResponding});
}

/// Bloc
class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  ChatbotBloc()
      : super(ChatbotInitial(conversation: [const ChatbotWelcome()])) {
    on<AskAQuestion>(_addUserMessage);
    on<ResetConversation>(_resetConversation);
    on<AnsweringAQuestion>(_answeringAQuestion);
    on<StopResponse>(_stopResponse);
    on<GoToUpgradeScreenEvent>(_goToUpgradeScreen);
  }

  List<Widget> listConversations = [const ChatbotWelcome()];
  final ScrollController conversationScrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  bool isReportedAboutDisconnection = false;
  final gemini = Gemini.instance;
  String currentResponseContent = "";
  final _isLoadingStreamController = StreamController<bool>();
  static final Content initContent = Content(
      parts: [Parts(text: 'Pretend you are a language teacher named Diccon.')],
      role: 'user');
  List<Content> multiTurnConversation = [initContent];

  Future<void> _addUserMessage(
      AskAQuestion event, Emitter<ChatbotState> emit) async {
    currentResponseContent = "";
    listConversations.insert(
        0,
        ConversationUserBubble(
          message: event.providedWord,
          onTap: () {
            textController.text = event.providedWord;
          },
        ));
    textController.clear();
    // Check internet connection before create request to chatbot
    bool isInternetConnected = await InternetConnectionChecker().hasConnection;
    if (kDebugMode) {
      print("[Internet Connection] $isInternetConnected");
    }
    if (!isInternetConnected) {
      listConversations.insert(0, const NoInternetBubble());
      emit(
          ChatbotUpdated(conversation: listConversations, isResponding: false));
      isReportedAboutDisconnection = true;
    } else {
      /// Process and return reply
      // Check if the amount of token is efficient to make the request
      if (FirebaseAuth.instance.currentUser != null || Platform.isWindows) {
        final numberOfTokenLeft = await Tokens.token;
        if (numberOfTokenLeft > 0) {
          final question = event.providedWord;
          multiTurnConversation.add(
            Content(parts: [Parts(text: question)], role: 'user'),
          );
          _gettingResponseFromGemini();
          listConversations.insert(
              0,
              const ConversationMachineBubble(
                content: "",
              ));
          emit(ChatbotUpdated(
              conversation: listConversations, isResponding: true));
          Tokens.reduceToken(byValueOf: 1);
        } else {
          emit(NotHaveEnoughToken());
        }
      } else {
        emit(RequiredLogIn());
      }
    }
  }

  _gettingResponseFromGemini() {
    try {
      _isLoadingStreamController.sink.add(true);
      gemini.streamChat(multiTurnConversation).listen((event) {
        currentResponseContent += event.output ?? '';
        add(AnsweringAQuestion(answer: currentResponseContent));
      }).onDone(() {
        multiTurnConversation.add(Content(
            parts: [Parts(text: currentResponseContent)], role: 'model'));
        add(StopResponse());
      });
    } catch (error) {
      _isLoadingStreamController.sink.add(false);
      DebugLog.error("Error occurred: $error");
    }
  }

  FutureOr<void> _resetConversation(
      ResetConversation event, Emitter<ChatbotState> emit) {
    multiTurnConversation = [initContent];
    listConversations = [const ChatbotWelcome()];
    emit(ChatbotUpdated(conversation: listConversations, isResponding: false));
  }

  FutureOr<void> _answeringAQuestion(
      AnsweringAQuestion event, Emitter<ChatbotState> emit) {
    listConversations.first = ConversationMachineBubble(content: event.answer);

    emit(ChatbotUpdated(conversation: listConversations, isResponding: true));
  }

  FutureOr<void> _stopResponse(StopResponse event, Emitter<ChatbotState> emit) {
    _isLoadingStreamController.sink.add(false);
    gemini.cancelRequest();
    emit(ChatbotUpdated(conversation: listConversations, isResponding: false));
  }

  FutureOr<void> _goToUpgradeScreen(
      GoToUpgradeScreenEvent event, Emitter<ChatbotState> emit) {
    emit(GoToUpgradeScreen());
  }
}
