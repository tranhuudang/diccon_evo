import 'package:freezed_annotation/freezed_annotation.dart';

part 'dialogue.freezed.dart';
part 'dialogue.g.dart';

@freezed
class Dialogue with _$Dialogue {
  const factory Dialogue({
    required String speaker,
    required String english,
    required String vietnamese,
  }) = _Dialogue;

  factory Dialogue.fromJson(Map<String, dynamic> json) => _$DialogueFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String title,
    required List<String> hashtags,
    required String description,
    required List<Dialogue> dialogue,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) => _$ConversationFromJson(json);
}
