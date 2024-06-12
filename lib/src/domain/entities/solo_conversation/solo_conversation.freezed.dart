// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'solo_conversation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Dialogue _$DialogueFromJson(Map<String, dynamic> json) {
  return _Dialogue.fromJson(json);
}

/// @nodoc
mixin _$Dialogue {
  String get speaker => throw _privateConstructorUsedError;
  String get english => throw _privateConstructorUsedError;
  String get vietnamese => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DialogueCopyWith<Dialogue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DialogueCopyWith<$Res> {
  factory $DialogueCopyWith(Dialogue value, $Res Function(Dialogue) then) =
      _$DialogueCopyWithImpl<$Res, Dialogue>;
  @useResult
  $Res call({String speaker, String english, String vietnamese});
}

/// @nodoc
class _$DialogueCopyWithImpl<$Res, $Val extends Dialogue>
    implements $DialogueCopyWith<$Res> {
  _$DialogueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speaker = null,
    Object? english = null,
    Object? vietnamese = null,
  }) {
    return _then(_value.copyWith(
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      vietnamese: null == vietnamese
          ? _value.vietnamese
          : vietnamese // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DialogueImplCopyWith<$Res>
    implements $DialogueCopyWith<$Res> {
  factory _$$DialogueImplCopyWith(
          _$DialogueImpl value, $Res Function(_$DialogueImpl) then) =
      __$$DialogueImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String speaker, String english, String vietnamese});
}

/// @nodoc
class __$$DialogueImplCopyWithImpl<$Res>
    extends _$DialogueCopyWithImpl<$Res, _$DialogueImpl>
    implements _$$DialogueImplCopyWith<$Res> {
  __$$DialogueImplCopyWithImpl(
      _$DialogueImpl _value, $Res Function(_$DialogueImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? speaker = null,
    Object? english = null,
    Object? vietnamese = null,
  }) {
    return _then(_$DialogueImpl(
      speaker: null == speaker
          ? _value.speaker
          : speaker // ignore: cast_nullable_to_non_nullable
              as String,
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      vietnamese: null == vietnamese
          ? _value.vietnamese
          : vietnamese // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DialogueImpl implements _Dialogue {
  const _$DialogueImpl(
      {required this.speaker, required this.english, required this.vietnamese});

  factory _$DialogueImpl.fromJson(Map<String, dynamic> json) =>
      _$$DialogueImplFromJson(json);

  @override
  final String speaker;
  @override
  final String english;
  @override
  final String vietnamese;

  @override
  String toString() {
    return 'Dialogue(speaker: $speaker, english: $english, vietnamese: $vietnamese)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DialogueImpl &&
            (identical(other.speaker, speaker) || other.speaker == speaker) &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.vietnamese, vietnamese) ||
                other.vietnamese == vietnamese));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, speaker, english, vietnamese);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DialogueImplCopyWith<_$DialogueImpl> get copyWith =>
      __$$DialogueImplCopyWithImpl<_$DialogueImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DialogueImplToJson(
      this,
    );
  }
}

abstract class _Dialogue implements Dialogue {
  const factory _Dialogue(
      {required final String speaker,
      required final String english,
      required final String vietnamese}) = _$DialogueImpl;

  factory _Dialogue.fromJson(Map<String, dynamic> json) =
      _$DialogueImpl.fromJson;

  @override
  String get speaker;
  @override
  String get english;
  @override
  String get vietnamese;
  @override
  @JsonKey(ignore: true)
  _$$DialogueImplCopyWith<_$DialogueImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Conversation _$ConversationFromJson(Map<String, dynamic> json) {
  return _Conversation.fromJson(json);
}

/// @nodoc
mixin _$Conversation {
  String get title => throw _privateConstructorUsedError;
  List<String> get hashtags => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  List<Dialogue> get dialogue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationCopyWith<Conversation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationCopyWith<$Res> {
  factory $ConversationCopyWith(
          Conversation value, $Res Function(Conversation) then) =
      _$ConversationCopyWithImpl<$Res, Conversation>;
  @useResult
  $Res call(
      {String title,
      List<String> hashtags,
      String description,
      List<Dialogue> dialogue});
}

/// @nodoc
class _$ConversationCopyWithImpl<$Res, $Val extends Conversation>
    implements $ConversationCopyWith<$Res> {
  _$ConversationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? hashtags = null,
    Object? description = null,
    Object? dialogue = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _value.hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dialogue: null == dialogue
          ? _value.dialogue
          : dialogue // ignore: cast_nullable_to_non_nullable
              as List<Dialogue>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationImplCopyWith<$Res>
    implements $ConversationCopyWith<$Res> {
  factory _$$ConversationImplCopyWith(
          _$ConversationImpl value, $Res Function(_$ConversationImpl) then) =
      __$$ConversationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> hashtags,
      String description,
      List<Dialogue> dialogue});
}

/// @nodoc
class __$$ConversationImplCopyWithImpl<$Res>
    extends _$ConversationCopyWithImpl<$Res, _$ConversationImpl>
    implements _$$ConversationImplCopyWith<$Res> {
  __$$ConversationImplCopyWithImpl(
      _$ConversationImpl _value, $Res Function(_$ConversationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? hashtags = null,
    Object? description = null,
    Object? dialogue = null,
  }) {
    return _then(_$ConversationImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      hashtags: null == hashtags
          ? _value._hashtags
          : hashtags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dialogue: null == dialogue
          ? _value._dialogue
          : dialogue // ignore: cast_nullable_to_non_nullable
              as List<Dialogue>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationImpl implements _Conversation {
  const _$ConversationImpl(
      {required this.title,
      required final List<String> hashtags,
      required this.description,
      required final List<Dialogue> dialogue})
      : _hashtags = hashtags,
        _dialogue = dialogue;

  factory _$ConversationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationImplFromJson(json);

  @override
  final String title;
  final List<String> _hashtags;
  @override
  List<String> get hashtags {
    if (_hashtags is EqualUnmodifiableListView) return _hashtags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_hashtags);
  }

  @override
  final String description;
  final List<Dialogue> _dialogue;
  @override
  List<Dialogue> get dialogue {
    if (_dialogue is EqualUnmodifiableListView) return _dialogue;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dialogue);
  }

  @override
  String toString() {
    return 'Conversation(title: $title, hashtags: $hashtags, description: $description, dialogue: $dialogue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._hashtags, _hashtags) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._dialogue, _dialogue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_hashtags),
      description,
      const DeepCollectionEquality().hash(_dialogue));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      __$$ConversationImplCopyWithImpl<_$ConversationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationImplToJson(
      this,
    );
  }
}

abstract class _Conversation implements Conversation {
  const factory _Conversation(
      {required final String title,
      required final List<String> hashtags,
      required final String description,
      required final List<Dialogue> dialogue}) = _$ConversationImpl;

  factory _Conversation.fromJson(Map<String, dynamic> json) =
      _$ConversationImpl.fromJson;

  @override
  String get title;
  @override
  List<String> get hashtags;
  @override
  String get description;
  @override
  List<Dialogue> get dialogue;
  @override
  @JsonKey(ignore: true)
  _$$ConversationImplCopyWith<_$ConversationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
