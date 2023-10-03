import 'dart:async';
import 'package:diccon_evo/data/repositories/chat_gpt_repository.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/chatbot_buble.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/dictionary_welcome_box.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/screens/dictionary/ui/components/dictionary_buble.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translator/translator.dart';
import '../../../config/properties.dart';
import '../../../data/data_providers/searching.dart';
import '../../../data/models/word.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../ui/components/brick_wall_buttons.dart';
import '../ui/components/image_buble.dart';

part 'chat_list_state.dart';
part 'chat_list_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc()
      : super(ChatListUpdated(chatList: [const DictionaryWelcome()])) {
    on<AddLocalTranslation>(_addLocalTranslation);
    on<AddUserMessage>(_addUserMessage);
    on<AddSorryMessage>(_addSorryMessage);
    on<AddSynonyms>(_addSynonymsList);
    on<AddAntonyms>(_addAntonymsList);
    on<AddImage>(_addImage);
    on<ScrollToBottom>(_scrollToBottom);
  }
  final translator = GoogleTranslator();
  final chatGptRepository = ChatGptRepository();
  final ScrollController chatListController = ScrollController();
  List<Widget> chatList = [const DictionaryWelcome()];

  Future<Translation> translate(String word) async {
    return await translator.translate(word, from: 'auto', to: 'vi');
  }

  /// Implement Events and Callbacks
  Future<void> _addImage(AddImage event, Emitter<ChatListState> emit) async {
    chatList.add(ImageBubble(imageUrl: event.imageUrl));
    emit(ChatListUpdated(chatList: chatList));
    _scrollChatListToBottom();

    emit(ImageAdded());
  }

  void _addSynonymsList(AddSynonyms event, Emitter<ChatListState> emit) {
    var listSynonyms = ThesaurusRepository().getSynonyms(event.providedWord);
    chatList.add(BrickWallButtons(stringList: listSynonyms));
    emit(ChatListUpdated(chatList: chatList));
    _scrollChatListToBottom();

    emit(SynonymsAdded());
  }

  void _addAntonymsList(AddAntonyms event, Emitter<ChatListState> emit) {
    var listAntonyms = ThesaurusRepository().getAntonyms(event.providedWord);
    chatList.add(BrickWallButtons(
        textColor: Colors.orange,
        borderColor: Colors.orangeAccent,
        stringList: listAntonyms));
    emit(ChatListUpdated(chatList: chatList));
    _scrollChatListToBottom();

    emit(AntonymsAdded());
  }

  void _addSorryMessage(AddSorryMessage event, Emitter<ChatListState> emit) {
    chatList.add(const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Sorry, we couldn't find this word at this time.")],
    ));
    emit(ChatListUpdated(chatList: chatList));
    _scrollChatListToBottom();
  }

  void _addUserMessage(AddUserMessage event, Emitter<ChatListState> emit) {
    var word = Word(word: event.providedWord);
    chatList.add(DictionaryBubble(isMachine: false, message: word));
    emit(ChatListUpdated(chatList: chatList));
    _scrollChatListToBottom();
  }

  Future<void> _addLocalTranslation(
      AddLocalTranslation event, Emitter<ChatListState> emit) async {
    if (Properties.chatbotEnable) {
      final question =
          'Hãy cho tôi biết phiên âm của từ "${event.providedWord}", sau đó giải thích nghĩa của từ "${event.providedWord}". Sau đó cho tôi ví dụ khi sử dụng từ "${event.providedWord}"';
      var request = await chatGptRepository.createSingleQuestionRequest(question);
      var answerIndex = chatGptRepository.questionAnswers.length - 1;
      chatList.add(ChatbotBubble(
        word : event.providedWord,
        questionRequest: request,
        chatGptRepository: chatGptRepository,
        answerIndex: answerIndex, chatListController: chatListController,
      ));
      emit(ChatListUpdated(chatList: chatList));
      _scrollChatListToBottom();
    } else {
      Word? wordResult = Searching.getDefinition(event.providedWord);
      if (wordResult != null) {
        /// Right bubble represent machine reply
        chatList.add(DictionaryBubble(isMachine: true, message: wordResult));
        emit(ChatListUpdated(chatList: chatList));
        _scrollChatListToBottom();
      } else {
        await translate(event.providedWord).then((translatedWord) {
          chatList.add(
            DictionaryBubble(
              isMachine: true,
              message:
                  Word(word: event.providedWord, meaning: translatedWord.text),
            ),
          );
          emit(ChatListUpdated(chatList: chatList));
          _scrollChatListToBottom();
        });
      }
    }
  }

  FutureOr<void> _scrollToBottom (ScrollToBottom event, Emitter<ChatListState> emit){
  _scrollChatListToBottom();
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
