// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'learned_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$LearnedWord {
  String get english => throw _privateConstructorUsedError;
  String get phonetic => throw _privateConstructorUsedError;
  String get vietnamese => throw _privateConstructorUsedError;
  int get counter => throw _privateConstructorUsedError;
  bool get isFavourite => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LearnedWordCopyWith<LearnedWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LearnedWordCopyWith<$Res> {
  factory $LearnedWordCopyWith(
          LearnedWord value, $Res Function(LearnedWord) then) =
      _$LearnedWordCopyWithImpl<$Res, LearnedWord>;
  @useResult
  $Res call(
      {String english,
      String phonetic,
      String vietnamese,
      int counter,
      bool isFavourite});
}

/// @nodoc
class _$LearnedWordCopyWithImpl<$Res, $Val extends LearnedWord>
    implements $LearnedWordCopyWith<$Res> {
  _$LearnedWordCopyWithImpl(this._value, this._then);

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
    Object? counter = null,
    Object? isFavourite = null,
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
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LearnWordImplCopyWith<$Res>
    implements $LearnedWordCopyWith<$Res> {
  factory _$$LearnWordImplCopyWith(
          _$LearnWordImpl value, $Res Function(_$LearnWordImpl) then) =
      __$$LearnWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String english,
      String phonetic,
      String vietnamese,
      int counter,
      bool isFavourite});
}

/// @nodoc
class __$$LearnWordImplCopyWithImpl<$Res>
    extends _$LearnedWordCopyWithImpl<$Res, _$LearnWordImpl>
    implements _$$LearnWordImplCopyWith<$Res> {
  __$$LearnWordImplCopyWithImpl(
      _$LearnWordImpl _value, $Res Function(_$LearnWordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? english = null,
    Object? phonetic = null,
    Object? vietnamese = null,
    Object? counter = null,
    Object? isFavourite = null,
  }) {
    return _then(_$LearnWordImpl(
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
      counter: null == counter
          ? _value.counter
          : counter // ignore: cast_nullable_to_non_nullable
              as int,
      isFavourite: null == isFavourite
          ? _value.isFavourite
          : isFavourite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LearnWordImpl implements _LearnWord {
  const _$LearnWordImpl(
      {required this.english,
      required this.phonetic,
      required this.vietnamese,
      required this.counter,
      required this.isFavourite});

  @override
  final String english;
  @override
  final String phonetic;
  @override
  final String vietnamese;
  @override
  final int counter;
  @override
  final bool isFavourite;

  @override
  String toString() {
    return 'LearnedWord(english: $english, phonetic: $phonetic, vietnamese: $vietnamese, counter: $counter, isFavourite: $isFavourite)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LearnWordImpl &&
            (identical(other.english, english) || other.english == english) &&
            (identical(other.phonetic, phonetic) ||
                other.phonetic == phonetic) &&
            (identical(other.vietnamese, vietnamese) ||
                other.vietnamese == vietnamese) &&
            (identical(other.counter, counter) || other.counter == counter) &&
            (identical(other.isFavourite, isFavourite) ||
                other.isFavourite == isFavourite));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, english, phonetic, vietnamese, counter, isFavourite);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LearnWordImplCopyWith<_$LearnWordImpl> get copyWith =>
      __$$LearnWordImplCopyWithImpl<_$LearnWordImpl>(this, _$identity);
}

abstract class _LearnWord implements LearnedWord {
  const factory _LearnWord(
      {required final String english,
      required final String phonetic,
      required final String vietnamese,
      required final int counter,
      required final bool isFavourite}) = _$LearnWordImpl;

  @override
  String get english;
  @override
  String get phonetic;
  @override
  String get vietnamese;
  @override
  int get counter;
  @override
  bool get isFavourite;
  @override
  @JsonKey(ignore: true)
  _$$LearnWordImplCopyWith<_$LearnWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
