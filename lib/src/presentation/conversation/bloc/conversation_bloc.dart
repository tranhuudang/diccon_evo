import 'dart:async';
import 'dart:io';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:diccon_evo/src/core/utils/open_ai_timer.dart';
import 'package:diccon_evo/src/core/utils/tokens.dart';
import 'package:diccon_evo/src/presentation/conversation/ui/components/conversation_wait_timer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../../core/configs/configs.dart';
import '../../../data/data.dart';

/// Events
@immutable
abstract class ConversationEvent {}

class AskAQuestion extends ConversationEvent {
  final String providedWord;
  AskAQuestion({required this.providedWord});
}

class AnsweringAQuestion extends ConversationEvent {
  final String answer;
  AnsweringAQuestion({required this.answer});
}

class ResetConversation extends ConversationEvent {}

class StopResponse extends ConversationEvent {}

/// State
abstract class ConversationState {}

abstract class ConversationActionState extends ConversationState {}

 class NotHaveEnoughToken extends ConversationActionState {}
 class RequiredLogIn extends ConversationActionState {}

class ConversationInitial extends ConversationState {
  List<Widget> conversation;
  ConversationInitial({required this.conversation});
}

class ConversationUpdated extends ConversationState {
  List<Widget> conversation;
  bool isResponding;
  ConversationUpdated({required this.conversation, required this.isResponding});
}

/// Bloc
class ConversationBloc extends Bloc<ConversationEvent, ConversationState> {
  ConversationBloc()
      : super(
            ConversationInitial(conversation: [const ConversationWelcome()])) {
    on<AskAQuestion>(_addUserMessage);
    on<ResetConversation>(_resetConversation);
    on<AnsweringAQuestion>(_answeringAQuestion);
    on<StopResponse>(_stopResponse);
  }

  final _chatGptRepository =
      ChatGptRepositoryImplement(chatGpt: ChatGpt(apiKey: ApiKeys.openAiKey));
  List<Widget> listConversations = [const ConversationWelcome()];
  final ScrollController conversationScrollController = ScrollController();
  final TextEditingController textController = TextEditingController();
  bool isReportedAboutDisconnection = false;

  String currentResponseContent = "";

  Future<void> _addUserMessage(
      AskAQuestion event, Emitter<ConversationState> emit) async {
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
    // Use timer to limit number of request per minute, so that open ai not break
    var openAITimer = OpenAITimer();
    openAITimer.trackRequest();
    var waitingSecondsLeft = openAITimer.secondsUntilNextRequest();
    if (kDebugMode) {
      print(
        'Delay $waitingSecondsLeft second to wait open ai before continue');
    }
    bool needRemoveTimerWidget = false;
    if (waitingSecondsLeft != 0){
      needRemoveTimerWidget = true;
      listConversations.insert(0, WaitTimerWidget(initialNumber: waitingSecondsLeft));
      emit(ConversationUpdated(
          conversation: listConversations, isResponding: true));
    }

    await Future.delayed(
        Duration(seconds: openAITimer.secondsUntilNextRequest()));
    if (needRemoveTimerWidget){
      listConversations.removeAt(0);
      emit(ConversationUpdated(
          conversation: listConversations, isResponding: true));
      needRemoveTimerWidget = false;
    }
    // Check internet connection before create request to chatbot
    bool isInternetConnected = await InternetConnectionChecker().hasConnection;
    if (kDebugMode) {
      print("[Internet Connection] $isInternetConnected");
    }
    if (!isInternetConnected) {
      listConversations.insert(0, const NoInternetBubble());
      emit(ConversationUpdated(
          conversation: listConversations, isResponding: false));
      isReportedAboutDisconnection = true;
    } else {
      /// Process and return reply
      // Check if the amount of token is efficient to make the request
      if (FirebaseAuth.instance.currentUser != null || Platform.isWindows) {
        final numberOfTokenLeft = await Tokens.token;
        if (numberOfTokenLeft > 0) {
          final question = event.providedWord;
          // create gpt request
          var request =
          await _chatGptRepository.createMultipleQuestionRequest(question);
          _chatStreamResponse(request);
          listConversations.insert(
              0,
              const ConversationMachineBubble(
                content: "",
              ));
          emit(ConversationUpdated(
              conversation: listConversations, isResponding: true));
          Tokens.reduceToken(byValueOf: 1);
        }
        else {
          emit(NotHaveEnoughToken());
        }
      }
      else {
        emit(RequiredLogIn());
      }
    }
  }

  FutureOr<void> _resetConversation(
      ResetConversation event, Emitter<ConversationState> emit) {
    _chatGptRepository.reset();
    listConversations = [const ConversationWelcome()];
    emit(ConversationUpdated(
        conversation: listConversations, isResponding: false));
  }

  FutureOr<void> _answeringAQuestion(
      AnsweringAQuestion event, Emitter<ConversationState> emit) {
    listConversations.first = ConversationMachineBubble(content: event.answer);

    emit(ConversationUpdated(
        conversation: listConversations, isResponding: true));
  }

  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  final _isLoadingStreamController = StreamController<bool>();

  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(true);
    try {
      final stream =
          await _chatGptRepository.chatGpt.createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen((event) {
        if (event.streamMessageEnd) {
          add(StopResponse());
        } else {
          currentResponseContent += event.choices!.first.delta!.content;
          add(AnsweringAQuestion(answer: currentResponseContent));
        }
      });
    } catch (error) {
      // setState(() {
      //   widget.chatGptRepository.questionAnswers.last.answer.write(
      //       "Error: The Diccon server is currently overloaded due to a high number of concurrent users.");
      // });
      if (kDebugMode) {
        print("Error occurred: $error");
      }
    }
  }

  FutureOr<void> _stopResponse(
      StopResponse event, Emitter<ConversationState> emit) {
    _chatStreamSubscription?.cancel();
    _isLoadingStreamController.sink.add(false);
    emit(ConversationUpdated(
        conversation: listConversations, isResponding: false));
  }
}
