import 'package:equatable/equatable.dart';

abstract class ListDialogueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadConversationsEvent extends ListDialogueEvent {
  final bool forceReload;
  LoadConversationsEvent({this.forceReload = false});
}

class GetSeenConversationEvent extends ListDialogueEvent {}

class GetUnreadConversationEvent extends ListDialogueEvent {}

class GetAllConversationEvent extends ListDialogueEvent {}
