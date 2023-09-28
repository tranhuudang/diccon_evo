part of 'chat_list_bloc.dart';

abstract class ChatListState {
}
abstract class ChatListActionState extends ChatListState {}

class ChatListInitial extends ChatListState {
  List<Widget> chatList;
  ChatListInitial({required this.chatList});
}

class ChatListUpdated extends ChatListState {
  List<Widget> chatList;
  ChatListUpdated({required this.chatList});
}

class SynonymsAdded extends ChatListActionState {
}

class AntonymsAdded extends ChatListActionState {
}

class ImageAdded extends ChatListActionState {
}

class ChatbotMessageAdded extends ChatListState{
  List<Widget> chatList;
  ChatbotMessageAdded({required this.chatList});
}

class ChatbotResponding extends ChatListState{
  String text;
  ChatbotResponding({required this.text});
}

