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

import '../../../../core/core.dart';
import '../../../../data/data.dart';
import '../../../../domain/domain.dart';

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
    on<CreateNewChatList>(_createNewChatList);
    on<AddTranslateWordFromSentence>(_addTranslateWordFromSentence);
    on<ChatBotResponding>(_chatBotResponding);
  }
  final gemini = Gemini.instance;

  final ScrollController chatListController = ScrollController();
  final TextEditingController textController = TextEditingController();
  List<Widget> _chatList = [const DictionaryWelcome()];
  bool _isReportedAboutDisconnection = false;
  final _wordHistoryBloc = WordHistoryBloc();
  String currentResponseContent = '';
  final EnglishToVietnameseDictionaryRepository dictionaryRepository =
      EnglishToVietnameseDictionaryRepositoryImpl();

  /// Implement Events and Callbacks
  Future<void> _addImage(AddImage event, Emitter<ChatListState> emit) async {
    _chatList.insert(0, ImageBubble(imageUrl: event.imageUrl));
    emit(ChatListUpdated(chatList: _chatList));
    emit(ImageAdded());
  }

  void _addSynonymsList(AddSynonyms event, Emitter<ChatListState> emit) async {
    var listSynonyms =
        await dictionaryRepository.getSynonyms(event.providedWord);
    _chatList.insert(0, BrickWallButtons(listString: listSynonyms));
    emit(ChatListUpdated(chatList: _chatList));
    emit(SynonymsAdded());
  }

  void _addTranslateWordFromSentence(
      AddTranslateWordFromSentence event, Emitter<ChatListState> emit) async {
    _chatList.insert(
        0,
        TranslatedWordInSentenceBubble(
            searchWord: event.word, sentenceContainWord: event.sentence));
    emit(ChatListUpdated(chatList: _chatList));
  }

  void _addAntonymsList(AddAntonyms event, Emitter<ChatListState> emit) async {
    var listAntonyms =
        await dictionaryRepository.getAntonyms(event.providedWord);
    _chatList.insert(
        0,
        BrickWallButtons(
            textColor: Colors.orange,
            borderColor: Colors.orangeAccent,
            listString: listAntonyms));
    emit(ChatListUpdated(chatList: _chatList));

    emit(AntonymsAdded());
  }

  void _addSorryMessage(AddSorryMessage event, Emitter<ChatListState> emit) {
    _chatList.insert(
        0,
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("Sorry, we couldn't find this word at this time.")],
        ));
    emit(ChatListUpdated(chatList: _chatList));
  }

  void _addUserMessage(AddUserMessage event, Emitter<ChatListState> emit) {
    final refinedWord = event.providedWord.trim().upperCaseFirstLetter();
    _chatList.insert(
        0,
        UserBubble(
          message: refinedWord,
          onTap: () {
            textController.text = refinedWord;
          },
        ));
    // Add word to history
    _wordHistoryBloc.add(AddWordToHistory(providedWord: refinedWord));
    emit(ChatListUpdated(chatList: _chatList));
  }

  Future<void> _addTranslation(
      AddTranslation event, Emitter<ChatListState> emit) async {
    {
      Settings currentSetting = Properties.instance.settings;
      // Check internet connection before create request to chat-bot
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print("[Internet Connection] $isInternetConnected");
      }
      if (!isInternetConnected && !_isReportedAboutDisconnection) {
        _chatList.insert(0, const NoInternetBubble());
        emit(ChatListUpdated(chatList: _chatList));
        _isReportedAboutDisconnection = true;
      }

      /// Detect language if auto detect language mode enable
      final languageIdentifier = LanguageIdentifier();
      String identifyLanguageResult =
          languageIdentifier.undeterminedLanguageCode;
      if (currentSetting.translationLanguageTarget ==
          TranslationLanguageTarget.autoDetect.title()) {
        identifyLanguageResult =
            languageIdentifier.identifyLanguage(event.providedWord);
      }

      String question = '';

      /// Check if setting force to translate from english to vietnamese
      // If autodetect is english or english to vietnamese mode enable
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

        _chatList.insert(
            0,
            DictionaryBubbleDefinition(
                word: event.providedWord, translation: ''));
        final isHavingData =
            await _getFirestoreData(word: event.providedWord, lang: 'en to vi');
        if (!isHavingData) {
          _getGeminiResponse(
              requestQuestion: question,
              word: event.providedWord,
              lang: 'en to vi');
        }
      }
      // If autodetect is vietnamese or vietnamese to english mode enable
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
        _chatList.insert(
            0,
            DictionaryBubbleDefinition(
                word: event.providedWord, translation: ''));
      }
    }
    emit(ChatListUpdated(chatList: _chatList));
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
      add(ChatBotResponding(translation: currentResponseContent, word: word));
    }).onDone(() {
      _createFirebaseDatabaseItem(
          lang: lang, word: word, translation: currentResponseContent);
      currentResponseContent = '';
    });
  }

  /// lang accept value: vi to en, en to vi
  Future<void> _createFirebaseDatabaseItem(
      {required String lang,
      required String word,
      required String translation}) async {
    final currentSettings = Properties.instance.settings;
    final answerId = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
        lang: lang,
        word: word,
        options: currentSettings
            .dictionaryResponseSelectedListVietnamese); // Generate the MD5 hash
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
    // create md5 from question to compare to see if that md5 is already exist in database
    var answer = Md5Generator.composeMd5IdForWordDefinitionFirebaseDb(
        lang: lang,
        word: word,
        options: currentSettings.dictionaryResponseSelectedListVietnamese);
    final docUser = firestore.FirebaseFirestore.instance
        .collection(FirebaseConstant.firestore.dictionary)
        .doc(answer);
    bool isHavingData = await docUser.get().then((snapshot) async {
      if (snapshot.exists) {
        add(ChatBotResponding(
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
      ChatBotResponding event, Emitter<ChatListState> emit) {
    _chatList.first = DictionaryBubbleDefinition(
        word: event.word, translation: event.translation);
    emit(ChatListUpdated(chatList: _chatList));
  }

  FutureOr<void> _createNewChatList(
      CreateNewChatList event, Emitter<ChatListState> emit) {
    currentResponseContent = '';
    textController.clear();
    _chatList = [const DictionaryWelcome()];
    emit(ChatListUpdated(chatList: _chatList));
  }
}
