part of 'dictionary_bloc.dart';

abstract class ChatListState {
}
abstract class ChatListActionState extends ChatListState {}

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

class ChatBotMessageAdded extends ChatListState{
  List<Widget> chatList;
  ChatBotMessageAdded({required this.chatList});
}



