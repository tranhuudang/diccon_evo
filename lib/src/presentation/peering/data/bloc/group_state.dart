part of 'group_bloc.dart';

class GroupChatParams {
  final bool isUploadingAttachFile;

  GroupChatParams({required this.isUploadingAttachFile});

  // The copyWith function
  GroupChatParams copyWith({bool? isUploadingAttachFile}) {
    return GroupChatParams(
      isUploadingAttachFile: isUploadingAttachFile ?? this.isUploadingAttachFile,
    );
  }
}

abstract class GroupChatState {
  final GroupChatParams params;
  GroupChatState({required this.params});
}

class GroupChatActionState extends GroupChatState {
  GroupChatActionState({required super.params});
}

class AttachFileTooLargeState extends GroupChatActionState{
  AttachFileTooLargeState({required super.params});
}

class GroupChatInitial extends GroupChatState {
  GroupChatInitial({required super.params});
}

class GroupChatLoading extends GroupChatState {
  GroupChatLoading({required super.params});
}

class GroupChatLoaded extends GroupChatState {
  GroupChatLoaded({required super.params});
}

class GroupChatError extends GroupChatState {
  GroupChatError({required super.params});
}
