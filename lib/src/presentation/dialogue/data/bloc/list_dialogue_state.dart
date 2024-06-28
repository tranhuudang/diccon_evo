import 'package:equatable/equatable.dart';

import '../../../../domain/domain.dart';

abstract class ListDialogueState extends Equatable {
  @override
  List<Object> get props => [];
}

class ListDialogueInitial extends ListDialogueState {}

class ListDialogueLoading extends ListDialogueState {}

class ListDialogueLoaded extends ListDialogueState {
  final List<Conversation> conversations;
  final List<String> haveReadDialogueDescriptionList;
  ListDialogueLoaded(this.conversations, this.haveReadDialogueDescriptionList);

  @override
  List<Object> get props => [conversations];
}

class ListDialogueError extends ListDialogueState {
  final String error;

  ListDialogueError(this.error);

  @override
  List<Object> get props => [error];
}
