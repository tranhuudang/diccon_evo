import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_compress/video_compress.dart';

import '../../../../core/utils/compressor.dart';

part 'group_chat_event.dart';
part 'group_chat_state.dart';

class GroupChatBloc extends Bloc<GroupChatEvent, GroupChatState> {
  GroupChatBloc()
      : super(GroupChatInitial([],
            params: GroupChatParams(isUploadingAttachFile: false))) {
    on<AddFileEvent>(_sendFileMessage);
    on<AddImageEvent>(_sendImageMessage);
    on<AddVideoEvent>(_sendVideoMessage);
    on<AddAudioEvent>(_sendAudioMessage);
    on<SendTextMessageEvent>(_sendTextMessage);
  }

  final TextEditingController messageController = TextEditingController();

  Future<FutureOr<void>> _sendFileMessage(
      AddFileEvent event, Emitter<GroupChatState> emit) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size <= 10 * 1024 * 1024) {
          // 10MB limit for file
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: true)));
          await uploadFile(file, event.groupId, isFile: true);
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: false)));
        } else {
          emit(AttachFileTooLargeState(state.chatList, params: state.params));
        }
      }
    }
  }

  Future<FutureOr<void>> _sendVideoMessage(
      AddVideoEvent event, Emitter<GroupChatState> emit) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.video);

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size <= 20 * 1024 * 1024) {
          // 20MB limit for video
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: true)));
          // Compress video
          final compressedVideo = await Compressor.compressVideo(
              file: file, quality: VideoQuality.MediumQuality);
          await uploadFile(compressedVideo, event.groupId, isVideo: true);
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: false)));
        } else {
          emit(AttachFileTooLargeState(state.chatList, params: state.params));
        }
      }
    }
  }

  Future<FutureOr<void>> _sendImageMessage(
      AddImageEvent event, Emitter<GroupChatState> emit) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size <= 5 * 1024 * 1024) {
          // 5MB limit for image
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: true)));
          // Compress image
          final compressedImage = await Compressor.compressImage(file: file);
          // Upload compressed file
          await uploadFile(compressedImage, event.groupId, isImage: true);
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: false)));
        } else {
          emit(AttachFileTooLargeState(state.chatList, params: state.params));
        }
      }
    }
  }

  Future<FutureOr<void>> _sendAudioMessage(
      AddAudioEvent event, Emitter<GroupChatState> emit) async {
    // Request storage permission
    PermissionStatus status = await Permission.storage.request();

    if (status.isGranted) {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.audio);

      if (result != null) {
        PlatformFile file = result.files.first;
        if (file.size <= 5 * 1024 * 1024) {
          // 5MB limit for audio
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: true)));
          await uploadFile(file, event.groupId, isAudio: true);
          emit(GroupChatLoaded(state.chatList,
              params: state.params.copyWith(isUploadingMediaFile: false)));
        } else {
          emit(AttachFileTooLargeState(state.chatList, params: state.params));
        }
      }
    }
  }

  Future<FutureOr<void>> _sendTextMessage(
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
      bool isFile = false,
      bool isImage = false,
      bool isAudio = false,
      bool isVideo = false}) async {
    await FirebaseFirestore.instance.collection('Messages').add({
      'group_id': groupId,
      'text': text,
      'senderId': senderId,
      'senderName': senderName,
      'timestamp': FieldValue.serverTimestamp(),
      'isImage': isImage,
      'isFile': isFile,
      'isVideo': isVideo,
      'isAudio': isAudio,
    });
  }

  Future<void> uploadFile(
    PlatformFile file,
    String groupId, {
    bool isFile = false,
    bool isImage = false,
    bool isVideo = false,
    bool isAudio = false,
  }) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('ChatFiles').child(file.name);
    late UploadTask uploadTask;
    if (isImage) {
      uploadTask = ref.putData(file.bytes!);
    } else {
      //if (isVideo || isFile || isAudio)
      uploadTask = ref.putFile(File(file.path!));
    }
    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await sendMessage(
      groupId: groupId,
      text: downloadUrl,
      senderName: FirebaseAuth.instance.currentUser?.displayName ?? 'Anonymous',
      senderId: FirebaseAuth.instance.currentUser?.uid ?? '',
      isFile: isFile,
      isImage: isImage,
      isVideo: isVideo,
      isAudio: isAudio,
    );
  }
}
