// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dialogue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DialogueImpl _$$DialogueImplFromJson(Map<String, dynamic> json) =>
    _$DialogueImpl(
      speaker: json['speaker'] as String,
      english: json['english'] as String,
      vietnamese: json['vietnamese'] as String,
    );

Map<String, dynamic> _$$DialogueImplToJson(_$DialogueImpl instance) =>
    <String, dynamic>{
      'speaker': instance.speaker,
      'english': instance.english,
      'vietnamese': instance.vietnamese,
    };

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      title: json['title'] as String,
      hashtags:
          (json['hashtags'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
      dialogue: (json['dialogue'] as List<dynamic>)
          .map((e) => Dialogue.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'hashtags': instance.hashtags,
      'description': instance.description,
      'dialogue': instance.dialogue,
    };
