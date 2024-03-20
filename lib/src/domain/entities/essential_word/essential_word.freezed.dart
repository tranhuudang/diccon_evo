// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'essential_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

EssentialWord _$EssentialWordFromJson(Map<String, dynamic> json) {
  return _EssentialWord.fromJson(json);
}

/// @nodoc
mixin _$EssentialWord {
  String get english => throw _privateConstructorUsedError;
  String get phonetic => throw _privateConstructorUsedError;
  String get vietnamese => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EssentialWordCopyWith<EssentialWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EssentialWordCopyWith<$Res> {
  factory $EssentialWordCopyWith(
          EssentialWord value, $Res Function(EssentialWord) then) =
      _$EssentialWordCopyWithImpl<$Res, EssentialWord>;
  @useResult
  $Res call({String english, String phonetic, String vietnamese});
}

/// @nodoc
class _$EssentialWordCopyWithImpl<$Res, $Val extends EssentialWord>
    implements $EssentialWordCopyWith<$Res> {
  _$EssentialWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? english = null,
    Object? phonetic = null,
    Object? vietnamese = null,
  }) {
    return _then(_value.copyWith(
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      phonetic: null == phonetic
          ? _value.phonetic
          : phonetic // ignore: cast_nullable_to_non_nullable
              as String,
      vietnamese: null == vietnamese
          ? _value.vietnamese
          : vietnamese // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$EssentialWordImplCopyWith<$Res>
    implements $EssentialWordCopyWith<$Res> {
  factory _$$EssentialWordImplCopyWith(
          _$EssentialWordImpl value, $Res Function(_$EssentialWordImpl) then) =
      __$$EssentialWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String english, String phonetic, String vietnamese});
}

/// @nodoc
class __$$EssentialWordImplCopyWithImpl<$Res>
    extends _$EssentialWordCopyWithImpl<$Res, _$EssentialWordImpl>
    implements _$$EssentialWordImplCopyWith<$Res> {
  __$$EssentialWordImplCopyWithImpl(
      _$EssentialWordImpl _value, $Res Function(_$EssentialWordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? english = null,
    Object? phonetic = null,
    Object? vietnamese = null,
  }) {
    return _then(_$EssentialWordImpl(
      english: null == english
          ? _value.english
          : english // ignore: cast_nullable_to_non_nullable
              as String,
      phonetic: null == phonetic
          ? _value.phonetic
          : phonetic // ignore: cast_nullable_to_non_nullable
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
class _$EssentialWordImpl implements _EssentialWord {
  const _$EssentialWordImpl(
      {required this.english,
      required this.phonetic,
      required this.vietnamese});

  factory _$EssentialWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$EssentialWordImplFromJson(json);

  @override
  final String english;
  @override
  final String phonetic;
  @override
  final String vietnamese;

  @override
  String toString() {
    return 'EssentialWord(english: $english, phonetic: $phonetic, vietnamese: $vietnamese)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EssentialWordImpl &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.phonetic, phonetic) ||
                other.phonetic == phonetic) &&
            (identical(other.vietnamese, vietnamese) ||
                other.vietnamese == vietnamese));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, english, phonetic, vietnamese);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$EssentialWordImplCopyWith<_$EssentialWordImpl> get copyWith =>
      __$$EssentialWordImplCopyWithImpl<_$EssentialWordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$EssentialWordImplToJson(
      this,
    );
  }
}

abstract class _EssentialWord implements EssentialWord {
  const factory _EssentialWord(
      {required final String english,
      required final String phonetic,
      required final String vietnamese}) = _$EssentialWordImpl;

  factory _EssentialWord.fromJson(Map<String, dynamic> json) =
      _$EssentialWordImpl.fromJson;

  @override
  String get english;
  @override
  String get phonetic;
  @override
  String get vietnamese;
  @override
  @JsonKey(ignore: true)
  _$$EssentialWordImplCopyWith<_$EssentialWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
