part of 'conversation_bloc.dart';

abstract class ConversationState {
}
abstract class ConversationActionState extends ConversationState {}

class ConversationInitial extends ConversationState {
  List<Widget> conversation;
  ConversationInitial({required this.conversation});
}

class ConversationUpdated extends ConversationState {
  List<Widget> conversation;
  ConversationUpdated({required this.conversation});
}

class SynonymsAdded extends ConversationActionState {
}

class AntonymsAdded extends ConversationActionState {
}

class ImageAdded extends ConversationActionState {
}

class ChatbotMessageAdded extends ConversationState{
  List<Widget> conversation;
  ChatbotMessageAdded({required this.conversation});
}

class ChatbotResponding extends ConversationState{
  String text;
  ChatbotResponding({required this.text});
}

