part of 'chat_list_bloc.dart';

abstract class ChatListState{
  List<Widget> chatList;
  ChatListState({required this.chatList});
}

class ChatListInitial extends ChatListState{
  ChatListInitial({required super.chatList});
}

class ChatListUpdated extends ChatListState{
  ChatListUpdated({required super.chatList});

}