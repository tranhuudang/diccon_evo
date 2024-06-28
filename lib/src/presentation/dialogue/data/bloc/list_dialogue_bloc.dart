import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../domain/domain.dart';
import 'list_dialogue_event.dart';
import 'list_dialogue_state.dart';

class ListDialogueBloc extends Bloc<ListDialogueEvent, ListDialogueState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ListDialogueBloc() : super(ListDialogueInitial()) {
    on<LoadConversations>(_onLoadConversations);
  }

  Future<void> _onLoadConversations(
      LoadConversations event, Emitter<ListDialogueState> emit) async {
    emit(ListDialogueLoading());

    try {
      // Fetch read conversations
      List<String> haveReadDialogueDescriptionList = [];
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final userDoc = await _firestore.collection('Users').doc(userId).get();

         haveReadDialogueDescriptionList = userDoc.exists
            ? List<String>.from(userDoc.data()?['readDialogueDescriptions'] ?? [])
            : [];
      }
      QuerySnapshot<Map<String, dynamic>> snapshot =
      await _firestore.collection('Dialogue').doc('Conversations').collection('Conversations').get();
      List<Conversation> conversations = snapshot.docs
          .map((doc) => Conversation.fromJson(doc.data()))
          .toList();

      emit(ListDialogueLoaded(conversations, haveReadDialogueDescriptionList));
    } catch (e) {
      emit(ListDialogueError('Error loading conversations: $e'));
    }
  }
}
