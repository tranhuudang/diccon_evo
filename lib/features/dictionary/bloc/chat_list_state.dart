part of 'chat_list_bloc.dart';

abstract class ChatListState {
  List<Widget> chatList;
  ChatListState({required this.chatList});
}

class ChatListInitial extends ChatListState {
  ChatListInitial({required super.chatList});
}

class ChatListUpdated extends ChatListState {
  ChatListUpdated({required super.chatList});
}

class SynonymsAdded extends ChatListState {
  SynonymsAdded({required super.chatList});
}

class AntonymsAdded extends ChatListState {
  AntonymsAdded({required super.chatList});
}

class ImageAdded extends ChatListState {
  ImageAdded({required super.chatList});
}

