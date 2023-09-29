part of 'conversation_bloc.dart';

@immutable
abstract class ConversationEvent{}

class AddUserMessage extends ConversationEvent{
  final String providedWord;
  AddUserMessage({required this.providedWord});
}

class AddBotReply extends ConversationEvent{
  final String providedWord;
  final Function(String)? onWordTap;
  AddBotReply({required this.onWordTap, required this.providedWord});
}


class AddSynonyms extends ConversationEvent{
  final String providedWord;
  final Function(String) itemOnPressed;
  AddSynonyms({ required this.providedWord,required this.itemOnPressed});
}

class AddAntonyms extends ConversationEvent{
  final String providedWord;
  final Function(String) itemOnPressed;
  AddAntonyms({ required this.providedWord,required this.itemOnPressed});
}

class AddImage extends ConversationEvent{
  final String imageUrl;
  AddImage({required this.imageUrl});
}

class AddSorryMessage extends ConversationEvent{
  AddSorryMessage();
}

