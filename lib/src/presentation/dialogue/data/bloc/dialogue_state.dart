import 'package:equatable/equatable.dart';

abstract class DialogueState extends Equatable {
  @override
  List<Object> get props => [];
}

class DialogueInitial extends DialogueState {}

class DialogueLoading extends DialogueState {}

class DialogueReadState extends DialogueState {
  final bool isRead;

  DialogueReadState(this.isRead);

  @override
  List<Object> get props => [isRead];
}

class NumberOfLikesState extends DialogueState {
  final int numberOfLikes;

  NumberOfLikesState(this.numberOfLikes);

  @override
  List<Object> get props => [numberOfLikes];
}

class FeedbackGivenState extends DialogueState {
  final bool isGivenFeedback;

  FeedbackGivenState(this.isGivenFeedback);

  @override
  List<Object> get props => [isGivenFeedback];
}

class DialogueError extends DialogueState {
  final String error;

  DialogueError(this.error);

  @override
  List<Object> get props => [error];
}
