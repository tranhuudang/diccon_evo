part of 'group_bloc.dart';

abstract class GroupChatEvent {}

class AttachFileTooLargeEvent extends GroupChatEvent{}

class LoadMessagesEvent extends GroupChatEvent {
  final String groupId;

  LoadMessagesEvent(this.groupId);
}

class SendTextMessageEvent extends GroupChatEvent {
  final String groupId;

  SendTextMessageEvent({
    required this.groupId
  });
}

class SendAttachFileEvent extends GroupChatEvent {
  final String groupId;

  SendAttachFileEvent(this.groupId);
}
