import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:diccon_evo/src/presentation/dictionary/ui/components/dictionary_bubble_definition.dart';
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
            params: ChatListParams(
          chatList: [const DictionaryWelcome()],
          showTranslateFromSentence: true,
          showSynonyms: false,
          showAntonyms: false,
          showRefreshAnswer: false,
          showImage: false,
          showSuggestionWords: false,
          suggestionWords: [],
          currentWord: '',
          imageUrl: '',
        ))) {
    on<GetTranslationEvent>(_getTranslation);
    on<AddUserMessageEvent>(_addUserMessage);
    on<AddSorryMessageEvent>(_addSorryMessage);
    on<GetSynonymsEvent>(_addSynonymsList);
    on<GetAntonymsEvent>(_addAntonymsList);
    on<ShowImageEvent>(_addImage);
    on<CreateNewChatListEvent>(_createNewChatList);
    on<AddTranslateWordFromSentenceEvent>(_addTranslateWordFromSentence);
    on<ChatBotRespondingEvent>(_chatBotResponding);
    on<OpenDictionaryToolsEvent>(_openDictionaryTools);
    on<ResetDictionaryToolsEvent>(_resetDictionaryTools);
    on<GetWordSuggestionEvent>(_getWordSuggestion);
    on<RefreshAnswerEvent>(_refreshAnswer);
  }

  final gemini = Gemini.instance;
  final ScrollController chatListController = ScrollController();
  final ImageHandler _imageProvider = ImageHandler();
  final settingBloc = SettingBloc();
  final TextEditingController textController = TextEditingController();
  bool _isReportedAboutDisconnection = false;
  final _wordHistoryBloc = WordHistoryBloc();
  String currentResponseContent = '';
  final suggestionWordListDb = SuggestionDatabase.instance;
  final EnglishToVietnameseDictionaryRepository dictionaryRepository =
      EnglishToVietnameseDictionaryRepositoryImpl();
  List<String> _listAntonyms = [];
  List<String> _listSynonyms = [];

  Future<void> _addImage(
      ShowImageEvent event, Emitter<ChatListState> emit) async {
    if (state.params.imageUrl.isNotEmpty) {
      final updatedChatList = List<Widget>.from(state.params.chatList)
        ..insert(0, DictionaryImageBubble(imageUrl: state.params.imageUrl));
      emit(ChatListUpdated(
        params: state.params.copyWith(
            chatList: updatedChatList, showImage: false, imageUrl: ''),
      ));
    }
  }

  Future<void> _refreshAnswer(
      RefreshAnswerEvent event, Emitter<ChatListState> emit) async {
    add(GetTranslationEvent(
        providedWord: state.params.currentWord, forceRegenerate: true));
    emit(ChatListUpdated(params: state.params.copyWith(showRefresh: false)));
  }

  void _addSynonymsList(
      GetSynonymsEvent event, Emitter<ChatListState> emit) async {
    if (_listSynonyms.isNotEmpty) {
      final updatedChatList = List<Widget>.from(state.params.chatList)
        ..insert(0, BrickWallButtons(listString: _listSynonyms));
      emit(ChatListUpdated(
        params: state.params
            .copyWith(chatList: updatedChatList, showSynonyms: false),
      ));
      _listSynonyms = [];
    }
  }

  void _addTranslateWordFromSentence(AddTranslateWordFromSentenceEvent event,
      Emitter<ChatListState> emit) async {
    final updatedChatList = List<Widget>.from(state.params.chatList)
      ..insert(
          0,
          TranslatedWordInSentenceBubble(
              searchWord: event.word, sentenceContainWord: event.sentence));
    emit(ChatListUpdated(
      params: state.params.copyWith(chatList: updatedChatList),
    ));
  }

  void _addAntonymsList(
      GetAntonymsEvent event, Emitter<ChatListState> emit) async {
    if (_listAntonyms.isNotEmpty) {
      final updatedChatList = List<Widget>.from(state.params.chatList)
        ..insert(
            0,
            BrickWallButtons(
                textColor: Colors.orange,
                borderColor: Colors.orangeAccent,
                listString: _listAntonyms));
      emit(ChatListUpdated(
        params: state.params
            .copyWith(chatList: updatedChatList, showAntonyms: false),
      ));
      _listAntonyms = [];
    }
  }

  void _addSorryMessage(
      AddSorryMessageEvent event, Emitter<ChatListState> emit) {
    final updatedChatList = List<Widget>.from(state.params.chatList)
      ..insert(
          0,
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("Sorry, we couldn't find this word at this time.")],
          ));
    emit(ChatListUpdated(
      params: state.params.copyWith(chatList: updatedChatList),
    ));
  }

  void _addUserMessage(AddUserMessageEvent event, Emitter<ChatListState> emit) {
    final refinedWord = event.providedWord.trim().upperCaseFirstLetter();
    final updatedChatList = List<Widget>.from(state.params.chatList)
      ..insert(
          0,
          UserBubble(
            message: refinedWord,
            onTap: () {
              textController.text = refinedWord;
            },
          ));
    _wordHistoryBloc.add(AddWordToHistory(providedWord: refinedWord));
    emit(ChatListUpdated(
      params: state.params.copyWith(chatList: updatedChatList),
    ));
  }

  Future<void> _getTranslation(
      GetTranslationEvent event, Emitter<ChatListState> emit) async {
    {
      textController.clear();

      /// Add left bubble as user message
      add(AddUserMessageEvent(providedWord: event.providedWord));

      FocusNode textFieldFocusNode = FocusNode();
      if (defaultTargetPlatform.isMobile()) {
        // Remove focus out of TextField in DictionaryView
        textFieldFocusNode.unfocus();
      } else {
        // On desktop we request focus, not on mobile
        textFieldFocusNode.requestFocus();
      }
      emit(ChatListUpdated(
          params: state.params.copyWith(showSuggestionWords: false)));
      add(OpenDictionaryToolsEvent(word: event.providedWord));
      Settings currentSetting = Properties.instance.settings;
      bool isInternetConnected =
          await InternetConnectionChecker().hasConnection;
      if (kDebugMode) {
        print("[Internet Connection] $isInternetConnected");
      }
      if (!isInternetConnected && !_isReportedAboutDisconnection) {
        final updatedChatList = List<Widget>.from(state.params.chatList)
          ..insert(0, const NoInternetBubble());
        emit(ChatListUpdated(
          params: state.params.copyWith(chatList: updatedChatList),
        ));
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

        final updatedChatList = List<Widget>.from(state.params.chatList)
          ..insert(
              0,
              DictionaryBubbleDefinition(
                  word: event.providedWord, translation: ''));
        emit(ChatListUpdated(
          params: state.params.copyWith(chatList: updatedChatList),
        ));

        /// Retrieve data from firebase if it already exists in it
        if (event.forceRegenerate!) {
          _getGeminiResponse(
              requestQuestion: question,
              word: event.providedWord,
              lang: 'en to vi');
        } else {
          final isHavingData = await _getFirestoreData(
              word: event.providedWord, lang: 'en to vi');
          if (!isHavingData) {
            _getGeminiResponse(
                requestQuestion: question,
                word: event.providedWord,
                lang: 'en to vi');
          }
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

        /// Retrieve data from firebase if it already exists in it
        if (event.forceRegenerate!) {
          _getGeminiResponse(
              requestQuestion: question,
              word: event.providedWord,
              lang: 'vi to en');
        } else {
          final isHavingData = await _getFirestoreData(
              word: event.providedWord, lang: 'vi to en');
          if (!isHavingData) {
            _getGeminiResponse(
                requestQuestion: question,
                word: event.providedWord,
                lang: 'vi to en');
          }
        }
        final updatedChatList = List<Widget>.from(state.params.chatList ?? [])
          ..insert(
              0,
              DictionaryBubbleDefinition(
                  word: event.providedWord, translation: ''));

        emit(ChatListUpdated(
          params: state.params.copyWith(chatList: updatedChatList),
        ));
      }
    }
  }

  _getGeminiResponse(
      {required String requestQuestion,
      required String word,
      required String lang}) {
    // gemini.streamGenerateContent(requestQuestion, safetySettings: [
    //   SafetySetting(
    //       category: SafetyCategory.dangerous,
    //       threshold: SafetyThreshold.blockNone),
    //   SafetySetting(
    //       category: SafetyCategory.harassment,
    //       threshold: SafetyThreshold.blockNone),
    //   SafetySetting(
    //       category: SafetyCategory.hateSpeech,
    //       threshold: SafetyThreshold.blockNone),
    //   SafetySetting(
    //       category: SafetyCategory.sexuallyExplicit,
    //       threshold: SafetyThreshold.blockNone)
    // ]).listen((event) {
    //   DebugLog.info('Gemini finish reason: ${event.finishReason}');
    //   currentResponseContent += event.output ?? ' ';
    //   add(ChatBotRespondingEvent(
    //       translation: currentResponseContent, word: word));
    // }).onDone(() {
    //   _createFirebaseDatabaseItem(
    //       lang: lang, word: word, translation: currentResponseContent);
    //   currentResponseContent = '';
    // });
    try {
      gemini.text(requestQuestion).then((onValue) {
        add(ChatBotRespondingEvent(
            translation: onValue?.output ?? '', word: word));
      });
    } catch (e) {
      DebugLog.error(e.toString());
    }
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
            translation: snapshot
                    .data()?['answer']
                    .toString()
                    .replaceAll('[', '')
                    .replaceAll(']', '') ??
                ''));
        return true;
      } else {
        return false;
      }
    });
    return isHavingData;
  }

  FutureOr<void> _chatBotResponding(
      ChatBotRespondingEvent event, Emitter<ChatListState> emit) {
    if (state.params.chatList.isNotEmpty) {
      final updatedChatList = List<Widget>.from(state.params.chatList ?? [])
        ..[0] = DictionaryBubbleDefinition(
            word: event.word, translation: event.translation);
      emit(ChatListUpdated(
        params: state.params.copyWith(
            chatList: updatedChatList,
            showRefresh: true,
            currentWord: event.word),
      ));
    }
  }

  FutureOr<void> _getWordSuggestion(
      GetWordSuggestionEvent event, Emitter<ChatListState> emit) async {
    Set<String> listStartWith = {};
    Set<String> listContains = {};
    List<String> suggestionWords = [];
    final suggestionWordList = await suggestionWordListDb.database;
    var refinedWord = event.word.toLowerCase();
    const int suggestionLimit = 5;
    if (refinedWord.length > 1) {
      for (final element in suggestionWordList) {
        if (element.startsWith(refinedWord)) {
          listStartWith.add(element);
          if (listStartWith.length >= suggestionLimit) {
            break;
          }
        } else if (element.contains(refinedWord) &&
            listContains.length < suggestionLimit) {
          listContains.add(element);
        }
      }
      if (settingBloc.state.params.translationLanguageTarget !=
          TranslationLanguageTarget.vietnameseToEnglish) {
        suggestionWords = [...listStartWith, ...listContains].toList();
        suggestionWords.reversed;
      }
      emit(ChatListUpdated(
          params: state.params.copyWith(
              suggestionWords: suggestionWords, showSuggestionWords: true)));
    } else {
      emit(ChatListUpdated(
          params: state.params.copyWith(showSuggestionWords: false)));
    }
  }

  FutureOr<void> _openDictionaryTools(
      OpenDictionaryToolsEvent event, Emitter<ChatListState> emit) async {
    // Get list of synonyms and antonyms
    _listSynonyms = await dictionaryRepository.getSynonyms(event.word);
    _listAntonyms = await dictionaryRepository.getAntonyms(event.word);

    /// Find image to show
    final imageUrl = await _imageProvider.getImageFromPixabay(event.word);
    if (imageUrl.isNotEmpty) {
      emit(ChatListUpdated(
        params: state.params.copyWith(imageUrl: imageUrl, showImage: true),
      ));
    }

    // Emit the updated state with the new tools configuration
    emit(ChatListUpdated(
      params: state.params.copyWith(
          showSynonyms: _listSynonyms.isNotEmpty,
          showAntonyms: _listAntonyms.isNotEmpty),
    ));
  }

  FutureOr<void> _resetDictionaryTools(
      ResetDictionaryToolsEvent event, Emitter<ChatListState> emit) async {
    emit(ChatListUpdated(
      params: state.params.copyWith(
          showSynonyms: false,
          showAntonyms: false,
          showSuggestionWords: false,
          showImage: false,
          showRefresh: false,
          showTranslateFromSentence: true),
    ));
  }

  FutureOr<void> _createNewChatList(
      CreateNewChatListEvent event, Emitter<ChatListState> emit) {
    currentResponseContent = '';
    textController.clear();
    final defaultListChat = [const DictionaryWelcome()];
    emit(ChatListUpdated(
      params: state.params.copyWith(chatList: defaultListChat),
    ));
  }

  @override
  Future<void> close() {
    _wordHistoryBloc.close();
    return super.close();
  }
}
