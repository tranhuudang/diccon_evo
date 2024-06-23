import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:diccon_evo/src/presentation/dictionary/ui/components/dictionary_bubble_definition.dart';
import 'package:diccon_evo/src/presentation/dictionary/ui/components/safety_bubble.dart';
import 'package:diccon_evo/src/presentation/dictionary/ui/components/translated_word_in_sentence_result_bubble.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/core.dart';
import '../../../../data/data.dart';
import '../../../../domain/domain.dart';

part 'dictionary_state.dart';
part 'dictionary_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc()
      : super(ChatListUpdated(
            chatList: [const DictionaryWelcome()],
            tools: DictionaryTools.init())) {
    on<AddTranslationEvent>(_addTranslation);
    on<AddUserMessageEvent>(_addUserMessage);
    on<AddSorryMessageEvent>(_addSorryMessage);
    on<GetSynonymsEvent>(_addSynonymsList);
    on<GetAntonymsEvent>(_addAntonymsList);
    on<GetImageEvent>(_addImage);
    on<CreateNewChatListEvent>(_createNewChatList);
    on<AddTranslateWordFromSentenceEvent>(_addTranslateWordFromSentence);
    on<ChatBotRespondingEvent>(_chatBotResponding);
  }

  final gemini = Gemini.instance;
  final ScrollController chatListController = ScrollController();
  final TextEditingController textController = TextEditingController();
  bool _isReportedAboutDisconnection = false;
  final _wordHistoryBloc = WordHistoryBloc();
  String currentResponseContent = '';
  final EnglishToVietnameseDictionaryRepository dictionaryRepository =
      EnglishToVietnameseDictionaryRepositoryImpl();

  /// Implement Events and Callbacks
  Future<void> _addImage(GetImageEvent event, Emitter<ChatListState> emit) async {
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(0, ImageBubble(imageUrl: event.imageUrl));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  void _addSynonymsList(GetSynonymsEvent event, Emitter<ChatListState> emit) async {
    var listSynonyms =
        await dictionaryRepository.getSynonyms(event.providedWord);
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(0, BrickWallButtons(listString: listSynonyms));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  void _addTranslateWordFromSentence(
      AddTranslateWordFromSentenceEvent event, Emitter<ChatListState> emit) async {
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(
          0,
          TranslatedWordInSentenceBubble(
              searchWord: event.word, sentenceContainWord: event.sentence));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  void _addAntonymsList(GetAntonymsEvent event, Emitter<ChatListState> emit) async {
    var listAntonyms =
        await dictionaryRepository.getAntonyms(event.providedWord);
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(
          0,
          BrickWallButtons(
              textColor: Colors.orange,
              borderColor: Colors.orangeAccent,
              listString: listAntonyms));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  void _addSorryMessage(AddSorryMessageEvent event, Emitter<ChatListState> emit) {
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(
          0,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Sorry, we couldn't find this word at this time.")],
          ));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  void _addUserMessage(AddUserMessageEvent event, Emitter<ChatListState> emit) {
    final refinedWord = event.providedWord.trim().upperCaseFirstLetter();
    final updatedChatList = List<Widget>.from(state.chatList ?? [])
      ..insert(
          0,
          UserBubble(
            message: refinedWord,
            onTap: () {
              textController.text = refinedWord;
            },
          ));
    _wordHistoryBloc.add(AddWordToHistory(providedWord: refinedWord));
    emit(ChatListUpdated(chatList: updatedChatList));
  }

  Future<void> _addTranslation(
      AddTranslationEvent event, Emitter<ChatListState> emit) async {
    {
      Settings currentSetting = Properties.instance.settings;
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print("[Internet Connection] $isInternetConnected");
      }
      if (!isInternetConnected && !_isReportedAboutDisconnection) {
        final updatedChatList = List<Widget>.from(state.chatList ?? [])
          ..insert(0, const NoInternetBubble());
        emit(ChatListUpdated(chatList: updatedChatList));
        _isReportedAboutDisconnection = true;
      }

      final languageIdentifier = LanguageIdentifier();
      String identifyLanguageResult =
          languageIdentifier.undeterminedLanguageCode;
      if (currentSetting.translationLanguageTarget ==
          TranslationLanguageTarget.autoDetect.title()) {
        identifyLanguageResult =
            languageIdentifier.identifyLanguage(event.providedWord);
      }

      String question = '';

      if ((identifyLanguageResult == languageIdentifier.englishLanguageCode &&
              currentSetting.translationLanguageTarget ==
                  TranslationLanguageTarget.englishToVietnamese.title()) ||
          (identifyLanguageResult == languageIdentifier.englishLanguageCode &&
              currentSetting.translationLanguageTarget ==
                  TranslationLanguageTarget.autoDetect.title())) {
        if (event.providedWord.split(' ').length > 2) {
          question = InAppStrings.getEnToViParagraphTranslateQuestion(
              event.providedWord);
        } else {
          question = InAppStrings.getEnToViSingleWordTranslateQuestion(
              event.providedWord);
        }

        final updatedChatList = List<Widget>.from(state.chatList ?? [])
          ..insert(
              0,
              DictionaryBubbleDefinition(
                  word: event.providedWord, translation: ''));
        emit(ChatListUpdated(chatList: updatedChatList));
        final isHavingData =
            await _getFirestoreData(word: event.providedWord, lang: 'en to vi');
        if (!isHavingData) {
          _getGeminiResponse(
              requestQuestion: question,
              word: event.providedWord,
              lang: 'en to vi');
        }
      }

      if (currentSetting.translationLanguageTarget ==
              TranslationLanguageTarget.vietnameseToEnglish.title() ||
          (identifyLanguageResult ==
                  languageIdentifier.vietnameseLanguageCode &&
              currentSetting.translationLanguageTarget ==
                  TranslationLanguageTarget.autoDetect.title())) {
        if (event.providedWord.split(' ').length > 2) {
          question = InAppStrings.getViToEnParagraphTranslateQuestion(
              event.providedWord);
        } else {
          question = InAppStrings.getViToEnSingleWordTranslateQuestion(
              event.providedWord);
        }
        _getGeminiResponse(
            requestQuestion: question,
            word: event.providedWord,
            lang: 'vi to en');
        final updatedChatList = List<Widget>.from(state.chatList ?? [])
          ..insert(
              0,
              DictionaryBubbleDefinition(
                  word: event.providedWord, translation: ''));
        emit(ChatListUpdated(chatList: updatedChatList));
      }
    }
  }

  _getGeminiResponse(
      {required String requestQuestion,
      required String word,
      required String lang}) {
    gemini.streamGenerateContent(requestQuestion, safetySettings: [
      SafetySetting(
          category: SafetyCategory.dangerous,
          threshold: SafetyThreshold.blockNone),
      SafetySetting(
          category: SafetyCategory.harassment,
          threshold: SafetyThreshold.blockNone),
      SafetySetting(
          category: SafetyCategory.hateSpeech,
          threshold: SafetyThreshold.blockNone),
      SafetySetting(
          category: SafetyCategory.sexuallyExplicit,
          threshold: SafetyThreshold.blockNone)
    ]).listen((event) {
      DebugLog.info('Gemini finish reason: ${event.finishReason}');
      currentResponseContent += event.output ?? ' ';
      add(ChatBotRespondingEvent(translation: currentResponseContent, word: word));
    }).onDone(() {
      _createFirebaseDatabaseItem(
          lang: lang, word: word, translation: currentResponseContent);
      currentResponseContent = '';
    });
  }

  Future<void> _createFirebaseDatabaseItem(
      {required String lang,
      required String word,
      required String translation}) async {
    final currentSettings = Properties.instance.settings;
    final answerId = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
        lang: lang,
        word: word,
        options: currentSettings.dictionaryResponseSelectedListVietnamese);
    final databaseRow = firestore.FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.dictionary)
        .doc(answerId);
    final json = {
      'question': word,
      'answer': translation,
    };
    await databaseRow.set(json);
  }

  Future<bool> _getFirestoreData(
      {required String word, required String lang}) async {
    final currentSettings = Properties.instance.settings;
    var answer = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
        lang: lang,
        word: word,
        options: currentSettings.dictionaryResponseSelectedListVietnamese);
    final docUser = firestore.FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.dictionary)
        .doc(answer);
    bool isHavingData = await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        add(ChatBotRespondingEvent(
            word: word,
            translation: snapshot.data()?['answer'].toString() ?? ''));
        return true;
      } else {
        return false;
      }
    });
    return isHavingData;
  }

  FutureOr<void> _chatBotResponding(
      ChatBotRespondingEvent event, Emitter<ChatListState> emit) {
    if (state.chatList != null && state.chatList!.isNotEmpty) {
      final updatedChatList = List<Widget>.from(state.chatList ?? [])
        ..[0] = DictionaryBubbleDefinition(
            word: event.word, translation: event.translation);
      emit(ChatListUpdated(chatList: updatedChatList));
    }
  }

  FutureOr<void> _createNewChatList(
      CreateNewChatListEvent event, Emitter<ChatListState> emit) {
    currentResponseContent = '';
    textController.clear();
    final defaultListChat = [const DictionaryWelcome()];
    emit(ChatListUpdated(chatList: defaultListChat));
  }
}
