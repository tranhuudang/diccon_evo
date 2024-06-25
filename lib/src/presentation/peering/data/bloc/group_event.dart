part of 'group_bloc.dart';

abstract class GroupChatEvent {}

class AttachFileTooLargeEvent extends GroupChatEvent {}

class LoadMessagesEvent extends GroupChatEvent {
  final String groupId;

  LoadMessagesEvent(this.groupId);
}

class SendTextMessageEvent extends GroupChatEvent {
  final String groupId;

  SendTextMessageEvent({required this.groupId});
}

class AddFileEvent extends GroupChatEvent {
  final String groupId;

  AddFileEvent(this.groupId);
}

class AddImageEvent extends GroupChatEvent {
  final String groupId;

  AddImageEvent(this.groupId);
}

class AddVideoEvent extends GroupChatEvent {
  final String groupId;

  AddVideoEvent(this.groupId);
}

class AddAudioEvent extends GroupChatEvent {
  final String groupId;

  AddAudioEvent(this.groupId);
}
