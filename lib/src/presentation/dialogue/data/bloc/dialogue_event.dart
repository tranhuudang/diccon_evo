import 'package:equatable/equatable.dart';

abstract class DialogueEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MarkAsRead extends DialogueEvent {
  final String description;

  MarkAsRead(this.description);

  @override
  List<Object> get props => [description];
}

class GetNumberOfLikes extends DialogueEvent {
  final String description;

  GetNumberOfLikes(this.description);

  @override
  List<Object> get props => [description];
}

class IncreaseLikeCount extends DialogueEvent {
  final String description;

  IncreaseLikeCount(this.description);

  @override
  List<Object> get props => [description];
}

class IncreaseDislikeCount extends DialogueEvent {
  final String description;

  IncreaseDislikeCount(this.description);

  @override
  List<Object> get props => [description];
}
