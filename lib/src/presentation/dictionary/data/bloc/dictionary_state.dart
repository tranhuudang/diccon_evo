part of 'dictionary_bloc.dart';

class DictionaryTools {
  final bool showTranslateFromSentence;
  final bool showSynonyms;
  final bool showAntonyms;
  final bool showRefresh;
  final bool showImage;

  DictionaryTools({
    required this.showTranslateFromSentence,
    required this.showSynonyms,
    required this.showAntonyms,
    required this.showRefresh,
    required this.showImage,
  });

  factory DictionaryTools.init() {
    return DictionaryTools(
      showTranslateFromSentence: true,
      showSynonyms: false,
      showAntonyms: false,
      showRefresh: false,
      showImage: false,
    );
  }

  DictionaryTools copyWith({
    bool? showTranslateFromSentence,
    bool? showSynonyms,
    bool? showAntonyms,
    bool? showRefresh,
    bool? showImage,
  }) {
    return DictionaryTools(
      showTranslateFromSentence:
          showTranslateFromSentence ?? this.showTranslateFromSentence,
      showSynonyms: showSynonyms ?? this.showSynonyms,
      showAntonyms: showAntonyms ?? this.showAntonyms,
      showRefresh: showRefresh ?? this.showRefresh,
      showImage: showImage ?? this.showImage,
    );
  }
}

abstract class ChatListState extends Equatable {
  final String? currentWord;
  final List<Widget>? chatList;
  final DictionaryTools? tools;

  const ChatListState({
    this.currentWord,
    this.chatList,
    this.tools,
  });

  @override
  List<Object?> get props => [currentWord, chatList, tools];
}

abstract class ChatListActionState extends ChatListState {
  const ChatListActionState({
    super.currentWord,
    super.chatList,
    super.tools,
  });
}

class ChatListUpdated extends ChatListState {
  const ChatListUpdated({
    super.currentWord,
    super.chatList,
    super.tools,
  });
}

class SynonymsAdded extends ChatListActionState {
  final List<String> synonyms;

  const SynonymsAdded({
    required this.synonyms,
    super.currentWord,
    super.chatList,
    super.tools,
  });

  @override
  List<Object?> get props => [synonyms, currentWord, chatList, tools];
}

class AntonymsAdded extends ChatListActionState {
  final List<String> antonyms;

  const AntonymsAdded({
    required this.antonyms,
    super.currentWord,
    super.chatList,
    super.tools,
  });

  @override
  List<Object?> get props => [antonyms, currentWord, chatList, tools];
}

class ImageAdded extends ChatListActionState {
  final String imageUrl;

  const ImageAdded({
    required this.imageUrl,
    super.currentWord,
    super.chatList,
    super.tools,
  });

  @override
  List<Object?> get props => [imageUrl, currentWord, chatList, tools];
}
