// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'text_recognizer_bloc_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TextRecognizerParams {
  String get filePath => throw _privateConstructorUsedError;
  String get rawContent => throw _privateConstructorUsedError;
  String get googleTranslatedContent => throw _privateConstructorUsedError;
  bool get isGoogleTranslating => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TextRecognizerParamsCopyWith<TextRecognizerParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TextRecognizerParamsCopyWith<$Res> {
  factory $TextRecognizerParamsCopyWith(TextRecognizerParams value,
          $Res Function(TextRecognizerParams) then) =
      _$TextRecognizerParamsCopyWithImpl<$Res, TextRecognizerParams>;
  @useResult
  $Res call(
      {String filePath,
      String rawContent,
      String googleTranslatedContent,
      bool isGoogleTranslating});
}

/// @nodoc
class _$TextRecognizerParamsCopyWithImpl<$Res,
        $Val extends TextRecognizerParams>
    implements $TextRecognizerParamsCopyWith<$Res> {
  _$TextRecognizerParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? rawContent = null,
    Object? googleTranslatedContent = null,
    Object? isGoogleTranslating = null,
  }) {
    return _then(_value.copyWith(
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      rawContent: null == rawContent
          ? _value.rawContent
          : rawContent // ignore: cast_nullable_to_non_nullable
              as String,
      googleTranslatedContent: null == googleTranslatedContent
          ? _value.googleTranslatedContent
          : googleTranslatedContent // ignore: cast_nullable_to_non_nullable
              as String,
      isGoogleTranslating: null == isGoogleTranslating
          ? _value.isGoogleTranslating
          : isGoogleTranslating // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TextRecognizerParamsImplCopyWith<$Res>
    implements $TextRecognizerParamsCopyWith<$Res> {
  factory _$$TextRecognizerParamsImplCopyWith(_$TextRecognizerParamsImpl value,
          $Res Function(_$TextRecognizerParamsImpl) then) =
      __$$TextRecognizerParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String filePath,
      String rawContent,
      String googleTranslatedContent,
      bool isGoogleTranslating});
}

/// @nodoc
class __$$TextRecognizerParamsImplCopyWithImpl<$Res>
    extends _$TextRecognizerParamsCopyWithImpl<$Res, _$TextRecognizerParamsImpl>
    implements _$$TextRecognizerParamsImplCopyWith<$Res> {
  __$$TextRecognizerParamsImplCopyWithImpl(_$TextRecognizerParamsImpl _value,
      $Res Function(_$TextRecognizerParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? filePath = null,
    Object? rawContent = null,
    Object? googleTranslatedContent = null,
    Object? isGoogleTranslating = null,
  }) {
    return _then(_$TextRecognizerParamsImpl(
      filePath: null == filePath
          ? _value.filePath
          : filePath // ignore: cast_nullable_to_non_nullable
              as String,
      rawContent: null == rawContent
          ? _value.rawContent
          : rawContent // ignore: cast_nullable_to_non_nullable
              as String,
      googleTranslatedContent: null == googleTranslatedContent
          ? _value.googleTranslatedContent
          : googleTranslatedContent // ignore: cast_nullable_to_non_nullable
              as String,
      isGoogleTranslating: null == isGoogleTranslating
          ? _value.isGoogleTranslating
          : isGoogleTranslating // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$TextRecognizerParamsImpl implements _TextRecognizerParams {
  const _$TextRecognizerParamsImpl(
      {required this.filePath,
      required this.rawContent,
      required this.googleTranslatedContent,
      required this.isGoogleTranslating});

  @override
  final String filePath;
  @override
  final String rawContent;
  @override
  final String googleTranslatedContent;
  @override
  final bool isGoogleTranslating;

  @override
  String toString() {
    return 'TextRecognizerParams(filePath: $filePath, rawContent: $rawContent, googleTranslatedContent: $googleTranslatedContent, isGoogleTranslating: $isGoogleTranslating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TextRecognizerParamsImpl &&
            (identical(other.filePath, filePath) ||
                other.filePath == filePath) &&
            (identical(other.rawContent, rawContent) ||
                other.rawContent == rawContent) &&
            (identical(
                    other.googleTranslatedContent, googleTranslatedContent) ||
                other.googleTranslatedContent == googleTranslatedContent) &&
            (identical(other.isGoogleTranslating, isGoogleTranslating) ||
                other.isGoogleTranslating == isGoogleTranslating));
  }

  @override
  int get hashCode => Object.hash(runtimeType, filePath, rawContent,
      googleTranslatedContent, isGoogleTranslating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TextRecognizerParamsImplCopyWith<_$TextRecognizerParamsImpl>
      get copyWith =>
          __$$TextRecognizerParamsImplCopyWithImpl<_$TextRecognizerParamsImpl>(
              this, _$identity);
}

abstract class _TextRecognizerParams implements TextRecognizerParams {
  const factory _TextRecognizerParams(
      {required final String filePath,
      required final String rawContent,
      required final String googleTranslatedContent,
      required final bool isGoogleTranslating}) = _$TextRecognizerParamsImpl;

  @override
  String get filePath;
  @override
  String get rawContent;
  @override
  String get googleTranslatedContent;
  @override
  bool get isGoogleTranslating;
  @override
  @JsonKey(ignore: true)
  _$$TextRecognizerParamsImplCopyWith<_$TextRecognizerParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
