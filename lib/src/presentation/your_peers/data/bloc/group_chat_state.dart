part of 'group_chat_bloc.dart';

class GroupChatParams {
  final bool isUploadingAttachFile;

  GroupChatParams({required this.isUploadingAttachFile});

  // The copyWith function
  GroupChatParams copyWith({bool? isUploadingMediaFile}) {
    return GroupChatParams(
      isUploadingAttachFile: isUploadingMediaFile ?? this.isUploadingAttachFile,
    );
  }
}

abstract class GroupChatState {
  final List<Widget> chatList;
  final GroupChatParams params;
  GroupChatState(this.chatList, {required this.params});
}

class GroupChatActionState extends GroupChatState {
  GroupChatActionState(super.chatList, {required super.params});
}

class AttachFileTooLargeState extends GroupChatActionState{
  AttachFileTooLargeState(super.chatList, {required super.params});
}

class GroupChatInitial extends GroupChatState {
  GroupChatInitial(super.chatList, {required super.params});
}

class GroupChatLoading extends GroupChatState {
  GroupChatLoading(super.chatList, {required super.params});
}

class GroupChatLoaded extends GroupChatState {
  GroupChatLoaded(super.chatList, {required super.params});
}

class GroupChatError extends GroupChatState {
  GroupChatError(super.chatList, {required super.params});
}
