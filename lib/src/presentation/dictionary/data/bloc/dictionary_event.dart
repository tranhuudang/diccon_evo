part of 'dictionary_bloc.dart';

@immutable
abstract class ChatListEvent {}

class AddUserMessageEvent extends ChatListEvent {
  final String providedWord;
  AddUserMessageEvent({required this.providedWord});
}

class GetTranslationEvent extends ChatListEvent {
  final String providedWord;
  final bool? forceRegenerate;
  GetTranslationEvent({this.forceRegenerate = false, required this.providedWord});
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

class ShowImageEvent extends ChatListEvent {
  ShowImageEvent();
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

class OpenDictionaryToolsEvent extends ChatListEvent{
  final String word;
  OpenDictionaryToolsEvent({required this.word});
}

class RefreshAnswerEvent extends ChatListEvent{
  RefreshAnswerEvent();
}

class ResetDictionaryToolsEvent extends ChatListEvent{
  ResetDictionaryToolsEvent();
}

class GetWordSuggestionEvent extends ChatListEvent{
  final String word;
  GetWordSuggestionEvent({required this.word});
}


