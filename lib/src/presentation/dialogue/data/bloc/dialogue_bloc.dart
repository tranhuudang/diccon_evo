import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dialogue_event.dart';
import 'dialogue_state.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';

class DialogueBloc extends Bloc<DialogueEvent, DialogueState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DialogueBloc() : super(DialogueInitial()) {
    on<MarkAsRead>(_onMarkAsRead);
    on<GetNumberOfLikes>(_onGetNumberOfLikes);
    on<IncreaseLikeCount>(_onIncreaseLikeCount);
    on<IncreaseDislikeCount>(_onIncreaseDislikeCount);
  }

  ScrollController scrollController = ScrollController();

  Future<void> _onMarkAsRead(
      MarkAsRead event, Emitter<DialogueState> emit) async {
    if (FirebaseAuth.instance.currentUser?.uid != null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      try {
        final userRef = _firestore.collection('Users').doc(userId);

        await _firestore.runTransaction((transaction) async {
          final snapshot = await transaction.get(userRef);
          if (!snapshot.exists) {
            transaction.set(userRef, {
              'readDialogueDescriptions': [event.description],
            });
          } else {
            List<dynamic> readDocuments =
                snapshot.get('readDialogueDescriptions') ?? [];
            if (!readDocuments.contains(event.description)) {
              readDocuments.add(event.description);
              transaction
                  .update(userRef, {'readDialogueDescriptions': readDocuments});
            }
          }
        });

        emit(DialogueReadState(true));
      } catch (e) {
        emit(DialogueError('Error marking as read: $e'));
      }
    }
  }

  Future<void> _onGetNumberOfLikes(
      GetNumberOfLikes event, Emitter<DialogueState> emit) async {
    try {
      final dialogueAnalysisRef =
          await _getDialogueAnalysisRef(event.description);
      DocumentSnapshot likeCountSnapshot = await dialogueAnalysisRef.get();
      emit(NumberOfLikesState(likeCountSnapshot['likeCount']));
    } catch (e) {
      emit(DialogueError('Error getting number of likes: $e'));
    }
  }

  Future<void> _onIncreaseLikeCount(
      IncreaseLikeCount event, Emitter<DialogueState> emit) async {
    try {
      final dialogueAnalysisRef =
          await _getDialogueAnalysisRef(event.description);
      await dialogueAnalysisRef.update({'likeCount': FieldValue.increment(1)});
      emit(FeedbackGivenState(true));
    } catch (e) {
      emit(DialogueError('Error increasing like count: $e'));
    }
  }

  Future<void> _onIncreaseDislikeCount(
      IncreaseDislikeCount event, Emitter<DialogueState> emit) async {
    try {
      final dialogueAnalysisRef =
          await _getDialogueAnalysisRef(event.description);
      await dialogueAnalysisRef
          .update({'dislikeCount': FieldValue.increment(1)});
      emit(FeedbackGivenState(true));
    } catch (e) {
      emit(DialogueError('Error increasing dislike count: $e'));
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> _getDialogueAnalysisRef(
      String description) async {
    final conversationMd5 = Md5Generator.composeMd5IdForDialogueReadState(
        fromConversationDescription: description);
    final dialogRef = _firestore.collection('dialogue').doc('statistics');
    final favouriteRef =
        dialogRef.collection('dialogueAnalysis').doc(conversationMd5);
    final favouriteSnapshot = await favouriteRef.get();
    if (!favouriteSnapshot.exists) {
      await favouriteRef.set({
        'dialogTitle': '',
        'hashtag': '',
        'readCount': 0,
        'likeCount': 0,
        'dislikeCount': 0
      });
    }
    return favouriteRef;
  }
}
