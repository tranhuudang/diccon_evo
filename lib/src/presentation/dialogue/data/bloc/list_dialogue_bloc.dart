import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/domain.dart';
import 'list_dialogue_event.dart';
import 'list_dialogue_state.dart';

class ListDialogueBloc extends Bloc<ListDialogueEvent, ListDialogueState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ListDialogueBloc() : super(ListDialogueInitial()) {
    on<LoadConversationsEvent>(_onLoadConversations);
    on<GetSeenConversationEvent>(_onGetSeenConversation);
    on<GetUnreadConversationEvent>(_onGetUnreadConversation);
    on<GetAllConversationEvent>(_onGetAllConversation);
  }

  List<Conversation> _tempConversations = [];
  List<String> _tempHaveReadDialogueDescriptionList = [];

  Future<void> _onGetSeenConversation(
      GetSeenConversationEvent event, Emitter<ListDialogueState> emit) async {
    final seenConversationList = _tempConversations
        .where((item) =>
            _tempHaveReadDialogueDescriptionList.contains(item.description))
        .toList();
    emit(ListDialogueLoaded(
        seenConversationList, _tempHaveReadDialogueDescriptionList));
  }

  Future<void> _onGetAllConversation(
      GetAllConversationEvent event, Emitter<ListDialogueState> emit) async {
    emit(ListDialogueLoaded(
        _tempConversations, _tempHaveReadDialogueDescriptionList));
  }

  Future<void> _onGetUnreadConversation(
      GetUnreadConversationEvent event, Emitter<ListDialogueState> emit) async {
    final unreadConversationList = _tempConversations
        .where((item) =>
            !_tempHaveReadDialogueDescriptionList.contains(item.description))
        .toList();
    emit(ListDialogueLoaded(
        unreadConversationList, _tempHaveReadDialogueDescriptionList));
  }

  Future<void> _onLoadConversations(
      LoadConversationsEvent event, Emitter<ListDialogueState> emit) async {
    if (_tempConversations.isNotEmpty && event.forceReload == false) {
      emit(ListDialogueLoaded(
          _tempConversations, _tempHaveReadDialogueDescriptionList));
    } else {
      emit(ListDialogueLoading());

      try {
        // Fetch read conversations
        List<String> haveReadDialogueDescriptionList = [];
        if (FirebaseAuth.instance.currentUser?.uid != null) {
          final userId = FirebaseAuth.instance.currentUser!.uid;
          final userDoc = await _firestore
              .collection('Users')
              .doc(userId)
              .collection('Dialogue')
              .doc('readDialogueDescriptions')
              .get();

          haveReadDialogueDescriptionList = userDoc.exists
              ? List<String>.from(
                  userDoc.data()?['readDialogueDescriptions'] ?? [])
              : [];
        }
        QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
            .collection('Dialogue')
            .doc('Conversations')
            .collection('Conversations')
            .get();
        List<Conversation> conversations = snapshot.docs
            .map((doc) => Conversation.fromJson(doc.data()))
            .toList();
        _tempConversations = conversations;
        _tempHaveReadDialogueDescriptionList =
            haveReadDialogueDescriptionList.reversed.toList();
        emit(ListDialogueLoaded(
            _tempConversations, _tempHaveReadDialogueDescriptionList));
      } catch (e) {
        emit(ListDialogueError('Error loading conversations: $e'));
      }
    }
  }
}
