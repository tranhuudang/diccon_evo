import 'package:diccon_evo/helpers/history_manager.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:diccon_evo/screens/components/dictionary_buble.dart';
import 'package:diccon_evo/helpers/searching.dart';
import 'package:translator/translator.dart';
import 'package:diccon_evo/config/properties.dart';
import '../../../helpers/file_handler.dart';
import '../../../models/word.dart';
import '../../components/brick_wall_buttons.dart';
import '../../components/image_buble.dart';
import '../../components/quote_box/ui/quote_box.dart';

part 'chat_list_state.dart';
part 'chat_list_event.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc() : super(ChatListInitial(chatList: [const WelcomeBox()])) {
    on<AddLocalTranslation>(_addLocalTranslation);
    on<AddUserMessage>(_addUserMessage);
    on<AddSorryMessage>(_addSorryMessage);
    on<AddSynonyms>(_addSynonymsList);
    on<AddAntonyms>(_addAntonymsList);
    on<AddImage>(_addImage);
  }
  final translator = GoogleTranslator();
  Future<Translation> translate(String word) async {
    return await translator.translate(word, from: 'auto', to: 'vi');
  }

  /// Implement Events and Callbacks

  Future<void> _addImage(AddImage event, Emitter<ChatListState> emit) async {
    state.chatList.add(ImageBubble(imageUrl: event.imageUrl));
    emit(ImageAdded(chatList: state.chatList));
  }

  void _addSynonymsList(AddSynonyms event, Emitter<ChatListState> emit) {
    var listSynonyms =
        Properties.thesaurusService.getSynonyms(event.providedWord);
    state.chatList.add(BrickWallButtons(
        stringList: listSynonyms, itemOnPressed: event.itemOnPressed));
    emit(SynonymsAdded(chatList: state.chatList));
  }

  void _addAntonymsList(AddAntonyms event, Emitter<ChatListState> emit) {
    var listAntonyms =
        Properties.thesaurusService.getAntonyms(event.providedWord);
    state.chatList.add(BrickWallButtons(
        textColor: Colors.orange,
        borderColor: Colors.orangeAccent,
        stringList: listAntonyms,
        itemOnPressed: event.itemOnPressed));
    emit(AntonymsAdded(chatList: state.chatList));
  }

  void _addSorryMessage(AddSorryMessage event, Emitter<ChatListState> emit) {
    state.chatList.add(const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text("Sorry, we couldn't find this word at this time.")],
    ));
    emit(ChatListUpdated(chatList: state.chatList));
  }

  void _addUserMessage(AddUserMessage event, Emitter<ChatListState> emit) {
    var word = Word(word: event.providedWord);
    state.chatList.add(DictionaryBubble(isMachine: false, message: word));
    emit(ChatListUpdated(chatList: state.chatList));
  }

  Future<void> _addLocalTranslation(
      AddLocalTranslation event, Emitter<ChatListState> emit) async {
    Word? wordResult = Searching.getDefinition(event.providedWord);
    if (wordResult != null) {
      /// Right bubble represent machine reply
      state.chatList.add(DictionaryBubble(
          isMachine: true, message: wordResult!, onWordTap: event.onWordTap));
      emit(ChatListUpdated(chatList: state.chatList));
      /// Add found word to history file
      await HistoryManager.saveWordToHistory(wordResult!);
    } else {
      await translate(event.providedWord).then((translatedWord) {
        state.chatList.add(DictionaryBubble(
            isMachine: true,
            message:
                Word(word: event.providedWord, meaning: translatedWord.text),
            onWordTap: event.onWordTap));
        emit(ChatListUpdated(chatList: state.chatList));
      });
    }
  }
}
