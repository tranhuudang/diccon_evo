part of 'dictionary_bloc.dart';

@immutable
abstract class ChatListEvent {}

class AddUserMessageEvent extends ChatListEvent {
  final String providedWord;
  AddUserMessageEvent({required this.providedWord});
}

class GetBasicTranslationEvent extends ChatListEvent {
  final String providedWord;
  final bool? forceRegenerate;
  GetBasicTranslationEvent({this.forceRegenerate = false, required this.providedWord});
}

class GetSpecializedTranslationEvent extends ChatListEvent {
  final String providedWord;
  final bool? forceRegenerate;
  GetSpecializedTranslationEvent({this.forceRegenerate = false, required this.providedWord});
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

class ChatBotBasicDefinitionRespondingEvent extends ChatListEvent{
  final String word;
  final String basicDefinition;
  ChatBotBasicDefinitionRespondingEvent({required this.word, required this.basicDefinition});
}

class ChatBotSpecializedDefinitionRespondingEvent extends ChatListEvent{
  final String word;
  final String specializedDefinition;
  ChatBotSpecializedDefinitionRespondingEvent({required this.word, required this.specializedDefinition});
}

class OpenDictionaryToolsEvent extends ChatListEvent{
  final String word;
  OpenDictionaryToolsEvent({required this.word});
}

class RefreshAnswerEvent extends ChatListEvent{
  RefreshAnswerEvent();
}

class RefreshSpecializedAnswerEvent extends ChatListEvent{
  RefreshSpecializedAnswerEvent();
}

class ResetDictionaryToolsEvent extends ChatListEvent{
  ResetDictionaryToolsEvent();
}

class GetWordSuggestionEvent extends ChatListEvent{
  final String word;
  GetWordSuggestionEvent({required this.word});
}


