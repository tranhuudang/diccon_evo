part of 'dictionary_bloc.dart';

@immutable
abstract class ChatListEvent{}

class AddUserMessage extends ChatListEvent{
  final String providedWord;
  AddUserMessage({required this.providedWord});
}

class AddTranslation extends ChatListEvent{
  final String providedWord;
  AddTranslation({required this.providedWord});
}


class AddSynonyms extends ChatListEvent{
  final String providedWord;
  final Function(String) itemOnPressed;
  AddSynonyms({ required this.providedWord,required this.itemOnPressed});
}

class AddAntonyms extends ChatListEvent{
  final String providedWord;
  final Function(String) itemOnPressed;
  AddAntonyms({ required this.providedWord,required this.itemOnPressed});
}

class AddImage extends ChatListEvent{
  final String imageUrl;
  AddImage({required this.imageUrl});
}

class AddSorryMessage extends ChatListEvent{
  AddSorryMessage();
}

class ScrollToBottom extends ChatListEvent{}
class CreateNewChatList extends ChatListEvent{}
class ForceTranslateVietnameseToEnglish extends ChatListEvent{}
class ForceTranslateEnglishToVietnamese extends ChatListEvent{}
class AutoDetectLanguage extends ChatListEvent{}

