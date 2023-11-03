// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StoryImpl _$$StoryImplFromJson(Map<String, dynamic> json) => _$StoryImpl(
      title: json['title'] as String,
      source: json['source'] as String?,
      imageUrl: json['imageUrl'] as String?,
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      content: json['content'] as String,
      shortDescription: json['shortDescription'] as String,
      level: json['level'] as String?,
    );

Map<String, dynamic> _$$StoryImplToJson(_$StoryImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'source': instance.source,
      'imageUrl': instance.imageUrl,
      'createdDate': instance.createdDate?.toIso8601String(),
      'content': instance.content,
      'shortDescription': instance.shortDescription,
      'level': instance.level,
    };
