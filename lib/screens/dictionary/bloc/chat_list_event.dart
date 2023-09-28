part of 'chat_list_bloc.dart';

@immutable
abstract class ChatListEvent{}

class AddUserMessage extends ChatListEvent{
  final String providedWord;
  AddUserMessage({required this.providedWord});
}

class AddLocalTranslation extends ChatListEvent{
  final String providedWord;
  final Function(String)? onWordTap;
  AddLocalTranslation({required this.onWordTap, required this.providedWord});
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

