import 'package:equatable/equatable.dart';

abstract class ListDialogueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadConversations extends ListDialogueEvent {}
