part of 'dictionary_bloc.dart';

class ChatListParams {
  final String currentWord;
  final List<Widget> chatList;
  final bool showTranslateFromSentence;
  final bool showSynonyms;
  final bool showAntonyms;
  final bool showRefresh;
  final bool showImage;
  final bool showSuggestionWords;
  final List<String> suggestionWords;

  ChatListParams({
    required this.showSuggestionWords,
    required this.suggestionWords,
    required this.currentWord,
    required this.chatList,
    required this.showTranslateFromSentence,
    required this.showSynonyms,
    required this.showAntonyms,
    required this.showRefresh,
    required this.showImage,
  });

  ChatListParams copyWith({
    String? currentWord,
    List<Widget>? chatList,
    bool? showTranslateFromSentence,
    bool? showSynonyms,
    bool? showAntonyms,
    bool? showRefresh,
    bool? showImage,
    bool? showSuggestionWords,
    List<String>? suggestionWords,
  }) {
    return ChatListParams(
      currentWord: currentWord ?? this.currentWord,
      chatList: chatList ?? this.chatList,
      showTranslateFromSentence:
          showTranslateFromSentence ?? this.showTranslateFromSentence,
      showSynonyms: showSynonyms ?? this.showSynonyms,
      showAntonyms: showAntonyms ?? this.showAntonyms,
      showRefresh: showRefresh ?? this.showRefresh,
      showImage: showImage ?? this.showImage,
      showSuggestionWords: showSuggestionWords ?? this.showSuggestionWords,
      suggestionWords: suggestionWords ?? this.suggestionWords,
    );
  }
}

abstract class ChatListState extends Equatable {
  final ChatListParams params;

  const ChatListState({
    required this.params,
  });

  @override
  List<Object?> get props => [params];
}

abstract class ChatListActionState extends ChatListState {
  const ChatListActionState({
    required ChatListParams params,
  }) : super(params: params);
}

class ChatListUpdated extends ChatListState {
  const ChatListUpdated({
    required ChatListParams params,
  }) : super(params: params);
}

class SynonymsAdded extends ChatListActionState {
  final List<String> synonyms;

  const SynonymsAdded({
    required this.synonyms,
    required ChatListParams params,
  }) : super(params: params);

  @override
  List<Object?> get props => [synonyms, params];
}

class AntonymsAdded extends ChatListActionState {
  final List<String> antonyms;

  const AntonymsAdded({
    required this.antonyms,
    required ChatListParams params,
  }) : super(params: params);

  @override
  List<Object?> get props => [antonyms, params];
}

class ImageAdded extends ChatListActionState {
  final String imageUrl;

  const ImageAdded({
    required this.imageUrl,
    required ChatListParams params,
  }) : super(params: params);

  @override
  List<Object?> get props => [imageUrl, params];
}
