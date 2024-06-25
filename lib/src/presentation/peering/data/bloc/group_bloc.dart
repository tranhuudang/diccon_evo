import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
part 'group_event.dart';
part 'group_state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  GroupChatBloc()
      : super(GroupChatInitial(
            params: GroupChatParams(isUploadingAttachFile: false))) {
    on<SendAttachFileEvent>(_sendAttachFileMessage);
    on<SendTextMessageEvent>(_sendTextMessageMessage);
  }

  final TextEditingController messageController = TextEditingController();


  Future<FutureOr<void>> _sendAttachFileMessage(
      SendAttachFileEvent event, Emitter<GroupChatState> emit) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size <= 10 * 1024 * 1024) {
          // 10MB limit
          emit(GroupChatLoaded(
              params: state.params.copyWith(isUploadingAttachFile: true)));
          await uploadFile(file, event.groupId);
          emit(GroupChatLoaded(
              params: state.params.copyWith(isUploadingAttachFile: false)));
        } else {
          emit(AttachFileTooLargeState(params: state.params));

        }
      }
    }
  }

  Future<FutureOr<void>> _sendTextMessageMessage(
      SendTextMessageEvent event, Emitter<GroupChatState> emit) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser!.uid;
    String userName = auth.currentUser!.displayName ?? 'Anonymous';

    sendMessage(
        groupId: event.groupId,
        text: messageController.text,
        senderId: userId,
        senderName: userName);
    messageController.clear();
  }

  Future<void> sendMessage(
      {required String groupId,
      required String text,
      required String senderId,
      required String senderName,
      bool isFile = false}) async {
    await FirebaseFirestore.instance.collection('Messages').add({
      'group_id': groupId,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
      'isFile': isFile,
    });
  }

  Future<void> uploadFile(PlatformFile file, String groupId) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('ChatFiles').child(file.name);
    UploadTask uploadTask = ref.putFile(File(file.path!));

    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await sendMessage(
        groupId: groupId,
        text: downloadUrl,
        senderName:
            FirebaseAuth.instance.currentUser?.displayName ?? 'Anonymous',
        senderId: FirebaseAuth.instance.currentUser?.uid ?? '',
        isFile: true);
  }
}
