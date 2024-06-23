part of 'dictionary_bloc.dart';

@immutable
abstract class ChatListEvent {}

class AddUserMessageEvent extends ChatListEvent {
  final String providedWord;
  AddUserMessageEvent({required this.providedWord});
}

class AddTranslationEvent extends ChatListEvent {
  final String providedWord;
  AddTranslationEvent({required this.providedWord});
}

class GetSynonymsEvent extends ChatListEvent {
  final String providedWord;
  final Function(String) itemOnPressed;
  GetSynonymsEvent({required this.providedWord, required this.itemOnPressed});
}

class GetAntonymsEvent extends ChatListEvent {
  final String providedWord;
  final Function(String) itemOnPressed;
  GetAntonymsEvent({required this.providedWord, required this.itemOnPressed});
}

class GetImageEvent extends ChatListEvent {
  final String imageUrl;
  GetImageEvent({required this.imageUrl});
}

class AddSorryMessageEvent extends ChatListEvent {
  AddSorryMessageEvent();
}

class CreateNewChatListEvent extends ChatListEvent {}

class AddTranslateWordFromSentenceEvent extends ChatListEvent {
  final String word;
  final String sentence;
  AddTranslateWordFromSentenceEvent({required this.word, required this.sentence});
}

class ChatBotRespondingEvent extends ChatListEvent{
  final String word;
  final String translation;
  ChatBotRespondingEvent({required this.word, required this.translation});
}
