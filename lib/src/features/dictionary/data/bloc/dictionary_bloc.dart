import 'dart:async';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/utils/language_identifier.dart';

import '../../../../core/core.dart';
// import 'package:google_mlkit_language_id/google_mlkit_language_id.dart';

part 'dictionary_state.dart';
part 'dictionary_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc()
      : super(ChatListUpdated(chatList: [const DictionaryWelcome()])) {
    on<AddTranslation>(_addTranslation);
    on<AddUserMessage>(_addUserMessage);
    on<AddSorryMessage>(_addSorryMessage);
    on<AddSynonyms>(_addSynonymsList);
    on<AddAntonyms>(_addAntonymsList);
    on<AddImage>(_addImage);
    on<ScrollToBottom>(_scrollToBottom);
    on<CreateNewChatList>(_createNewChatList);
  }
  List<ChatGptRepository> _listChatGptRepository = [];
  final ScrollController chatListController = ScrollController();
  final TextEditingController textController = TextEditingController();
  List<Widget> _chatList = [const DictionaryWelcome()];
  bool _isReportedAboutDisconnection = false;
  final _wordHistoryBloc = WordHistoryBloc();
  final EnglishToVietnameseDictionaryRepository dictionaryRepository =
      EnglishToVietnameseDictionaryRepositoryImpl();

  /// Implement Events and Callbacks
  Future<void> _addImage(AddImage event, Emitter<ChatListState> emit) async {
    _chatList.add(ImageBubble(imageUrl: event.imageUrl));
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();
    emit(ImageAdded());
  }

  void _addSynonymsList(AddSynonyms event, Emitter<ChatListState> emit) async {
    var listSynonyms =
        await dictionaryRepository.getSynonyms(event.providedWord);
    _chatList.add(BrickWallButtons(listString: listSynonyms));
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();
    emit(SynonymsAdded());
  }

  void _addAntonymsList(AddAntonyms event, Emitter<ChatListState> emit) async {
    var listAntonyms =
        await dictionaryRepository.getAntonyms(event.providedWord);
    _chatList.add(BrickWallButtons(
        textColor: Colors.orange,
        borderColor: Colors.orangeAccent,
        listString: listAntonyms));
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();

    emit(AntonymsAdded());
  }

  void _addSorryMessage(AddSorryMessage event, Emitter<ChatListState> emit) {
    _chatList.add(const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Sorry, we couldn't find this word at this time.")],
    ));
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();
  }

  void _addUserMessage(AddUserMessage event, Emitter<ChatListState> emit) {
    final refinedWord = event.providedWord.trim().upperCaseFirstLetter();
    _chatList.add(UserBubble(
      message: refinedWord,
      onTap: () {
        textController.text = refinedWord;
      },
    ));
    // Add word to history
    _wordHistoryBloc.add(AddWordToHistory(providedWord: refinedWord));
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();
  }

  Future<void> _addTranslation(
      AddTranslation event, Emitter<ChatListState> emit) async {
    Settings currentSetting = Properties.instance.settings;
    // Check internet connection before create request to chat-bot
    bool isInternetConnected = await InternetConnectionChecker().hasConnection;
    if (kDebugMode) {
      print("[Internet Connection] $isInternetConnected");
    }
    if (currentSetting.translationChoice.toTranslationChoice() ==
            TranslationChoices.explain &&
        !isInternetConnected &&
        !_isReportedAboutDisconnection) {
      _chatList.add(const NoInternetBubble());
      emit(ChatListUpdated(chatList: _chatList));
      _isReportedAboutDisconnection = true;
    }
    var newChatGptRepository =
        ChatGptRepositoryImplement(chatGpt: ChatGpt(apiKey: Env.openaiApiKey));
    _listChatGptRepository.add(newChatGptRepository);
    var chatGptRepositoryIndex = _listChatGptRepository.length - 1;

    /// Detect language if auto detect language mode enable
    final languageIdentifier = LanguageIdentifier();
    String identifyLanguageResult = languageIdentifier.undeterminedLanguageCode;
    if (currentSetting.translationLanguageTarget ==
        TranslationLanguageTarget.autoDetect.title()) {
      identifyLanguageResult =
          languageIdentifier.identifyLanguage(event.providedWord);
    }

    /// Check if setting force to translate from english to vietnamese
    if (identifyLanguageResult == languageIdentifier.englishLanguageCode ||
        currentSetting.translationLanguageTarget ==
            TranslationLanguageTarget.englishToVietnamese.title()) {
      var wordResult =
          await _getLocalEnglishToVietnameseTranslation(event.providedWord);
      _chatList.add(EnglishToVietnameseCombineBubble(
          wordObjectForLocal: wordResult,
          wordForChatBot: event.providedWord,
          chatListController: chatListController,
          index: chatGptRepositoryIndex,
          listChatGptRepository: _listChatGptRepository));
    }
    if (identifyLanguageResult == languageIdentifier.vietnameseLanguageCode ||
        currentSetting.translationLanguageTarget ==
            TranslationLanguageTarget.vietnameseToEnglish.title()) {
      var wordResult =
          await _getLocalVietnameseToEnglishTranslation(event.providedWord);
      _chatList.add(VietnameseToEnglishCombineBubble(
          wordObjectForLocal: wordResult,
          wordForChatBot: event.providedWord,
          chatListController: chatListController,
          index: chatGptRepositoryIndex,
          listChatGptRepository: _listChatGptRepository));
    }
    emit(ChatListUpdated(chatList: _chatList));
    _scrollChatListToBottom();
  }

  FutureOr<void> _createNewChatList(
      CreateNewChatList event, Emitter<ChatListState> emit) {
    _listChatGptRepository = [];
    textController.clear();
    _chatList = [const DictionaryWelcome()];
    emit(ChatListUpdated(chatList: _chatList));
  }

  FutureOr<void> _scrollToBottom(
      ScrollToBottom event, Emitter<ChatListState> emit) {
    _scrollChatListToBottom();
  }

  Future<Word> _getLocalEnglishToVietnameseTranslation(
      String providedWord) async {
    EnglishToVietnameseDictionaryRepository searchingEngine =
        EnglishToVietnameseDictionaryRepositoryImpl();
    Word? wordResult = await searchingEngine.getDefinition(providedWord);
    if (wordResult != Word.empty()) {
      if (kDebugMode) {
        print("got result from local dictionary");
      }
      return wordResult;
    }
    var badResult = Word(
        word: providedWord, definition: "WordNotFoundInLocalDictionary".i18n);
    return badResult;
  }

  Future<Word> _getLocalVietnameseToEnglishTranslation(
      String providedWord) async {
    VietnameseToEnglishDictionaryRepository searchingEngine =
        VietnameseToEnglishDictionaryRepositoryImpl();
    Word? wordResult = await searchingEngine.getDefinition(providedWord);
    if (wordResult != Word.empty()) {
      if (kDebugMode) {
        print("got result from local dictionary");
      }
      return wordResult;
    }
    var badResult = Word(
        word: providedWord, definition: "WordNotFoundInLocalDictionary".i18n);
    return badResult;
  }

  void _scrollChatListToBottom() {
    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      chatListController.animateTo(
        chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }
}
