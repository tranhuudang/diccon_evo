// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Settings {
  /// Save current theme of this app in this param, it holds string value of [ThemeMode] with value:
  /// ThemeMode.system, ThemeMode.dark, ThemeMode.light
  String get themeMode => throw _privateConstructorUsedError;

  /// Number of Synonyms is the number of Synonyms displayed in dictionary
  int get numberOfSynonyms => throw _privateConstructorUsedError;

  /// Number of Antonyms is the number of Antonyms displayed in dictionary
  int get numberOfAntonyms => throw _privateConstructorUsedError;

  /// Adaptive theme use DynamicTheme package to generate colorScheme
  bool get enableAdaptiveTheme => throw _privateConstructorUsedError;

  /// Open app count will trigger a specific function when user use app for a period of time
  int get openAppCount => throw _privateConstructorUsedError;

  /// This reading font size used in story reading view
  double get readingFontSize => throw _privateConstructorUsedError;

  /// Number of word when practice will be count down and save in this property
  int get numberOfEssentialLeft => throw _privateConstructorUsedError;

  /// Hold slider value of reading font size in settings
  double get readingFontSizeSliderValue => throw _privateConstructorUsedError;

  /// Language of app, those value : English, Tiếng Việt, System default will be convert
  /// to [Locale('en', 'US')] to change value of the app
  String get language => throw _privateConstructorUsedError;

  /// Custom for response in dictionary
  String get dictionaryResponseSelectedListVietnamese =>
      throw _privateConstructorUsedError;

  /// Custom for response in dictionary
  String get dictionaryResponseSelectedListEnglish =>
      throw _privateConstructorUsedError;

  /// Save target translate language with defined language in , currently support:
  /// englishToVietnamese, vietnameseToEnglish, autoDetect
  String get translationLanguageTarget => throw _privateConstructorUsedError;

  /// Hold windows size value
  double get windowsWidth => throw _privateConstructorUsedError;

  /// Hold windows size value
  double get windowsHeight => throw _privateConstructorUsedError;

  /// The app support two type of translation, using classic dictionary or use AI to
  /// generate answer. That's include: AI, Classic.
  String get translationChoice => throw _privateConstructorUsedError;

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  int get themeColor => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsCopyWith<Settings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsCopyWith<$Res> {
  factory $SettingsCopyWith(Settings value, $Res Function(Settings) then) =
      _$SettingsCopyWithImpl<$Res, Settings>;
  @useResult
  $Res call(
      {String themeMode,
      int numberOfSynonyms,
      int numberOfAntonyms,
      bool enableAdaptiveTheme,
      int openAppCount,
      double readingFontSize,
      int numberOfEssentialLeft,
      double readingFontSizeSliderValue,
      String language,
      String dictionaryResponseSelectedListVietnamese,
      String dictionaryResponseSelectedListEnglish,
      String translationLanguageTarget,
      double windowsWidth,
      double windowsHeight,
      String translationChoice,
      int themeColor});
}

/// @nodoc
class _$SettingsCopyWithImpl<$Res, $Val extends Settings>
    implements $SettingsCopyWith<$Res> {
  _$SettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? numberOfSynonyms = null,
    Object? numberOfAntonyms = null,
    Object? enableAdaptiveTheme = null,
    Object? openAppCount = null,
    Object? readingFontSize = null,
    Object? numberOfEssentialLeft = null,
    Object? readingFontSizeSliderValue = null,
    Object? language = null,
    Object? dictionaryResponseSelectedListVietnamese = null,
    Object? dictionaryResponseSelectedListEnglish = null,
    Object? translationLanguageTarget = null,
    Object? windowsWidth = null,
    Object? windowsHeight = null,
    Object? translationChoice = null,
    Object? themeColor = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfSynonyms: null == numberOfSynonyms
          ? _value.numberOfSynonyms
          : numberOfSynonyms // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfAntonyms: null == numberOfAntonyms
          ? _value.numberOfAntonyms
          : numberOfAntonyms // ignore: cast_nullable_to_non_nullable
              as int,
      enableAdaptiveTheme: null == enableAdaptiveTheme
          ? _value.enableAdaptiveTheme
          : enableAdaptiveTheme // ignore: cast_nullable_to_non_nullable
              as bool,
      openAppCount: null == openAppCount
          ? _value.openAppCount
          : openAppCount // ignore: cast_nullable_to_non_nullable
              as int,
      readingFontSize: null == readingFontSize
          ? _value.readingFontSize
          : readingFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfEssentialLeft: null == numberOfEssentialLeft
          ? _value.numberOfEssentialLeft
          : numberOfEssentialLeft // ignore: cast_nullable_to_non_nullable
              as int,
      readingFontSizeSliderValue: null == readingFontSizeSliderValue
          ? _value.readingFontSizeSliderValue
          : readingFontSizeSliderValue // ignore: cast_nullable_to_non_nullable
              as double,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryResponseSelectedListVietnamese: null ==
              dictionaryResponseSelectedListVietnamese
          ? _value.dictionaryResponseSelectedListVietnamese
          : dictionaryResponseSelectedListVietnamese // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryResponseSelectedListEnglish: null ==
              dictionaryResponseSelectedListEnglish
          ? _value.dictionaryResponseSelectedListEnglish
          : dictionaryResponseSelectedListEnglish // ignore: cast_nullable_to_non_nullable
              as String,
      translationLanguageTarget: null == translationLanguageTarget
          ? _value.translationLanguageTarget
          : translationLanguageTarget // ignore: cast_nullable_to_non_nullable
              as String,
      windowsWidth: null == windowsWidth
          ? _value.windowsWidth
          : windowsWidth // ignore: cast_nullable_to_non_nullable
              as double,
      windowsHeight: null == windowsHeight
          ? _value.windowsHeight
          : windowsHeight // ignore: cast_nullable_to_non_nullable
              as double,
      translationChoice: null == translationChoice
          ? _value.translationChoice
          : translationChoice // ignore: cast_nullable_to_non_nullable
              as String,
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingImplCopyWith<$Res> implements $SettingsCopyWith<$Res> {
  factory _$$SettingImplCopyWith(
          _$SettingImpl value, $Res Function(_$SettingImpl) then) =
      __$$SettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String themeMode,
      int numberOfSynonyms,
      int numberOfAntonyms,
      bool enableAdaptiveTheme,
      int openAppCount,
      double readingFontSize,
      int numberOfEssentialLeft,
      double readingFontSizeSliderValue,
      String language,
      String dictionaryResponseSelectedListVietnamese,
      String dictionaryResponseSelectedListEnglish,
      String translationLanguageTarget,
      double windowsWidth,
      double windowsHeight,
      String translationChoice,
      int themeColor});
}

/// @nodoc
class __$$SettingImplCopyWithImpl<$Res>
    extends _$SettingsCopyWithImpl<$Res, _$SettingImpl>
    implements _$$SettingImplCopyWith<$Res> {
  __$$SettingImplCopyWithImpl(
      _$SettingImpl _value, $Res Function(_$SettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? numberOfSynonyms = null,
    Object? numberOfAntonyms = null,
    Object? enableAdaptiveTheme = null,
    Object? openAppCount = null,
    Object? readingFontSize = null,
    Object? numberOfEssentialLeft = null,
    Object? readingFontSizeSliderValue = null,
    Object? language = null,
    Object? dictionaryResponseSelectedListVietnamese = null,
    Object? dictionaryResponseSelectedListEnglish = null,
    Object? translationLanguageTarget = null,
    Object? windowsWidth = null,
    Object? windowsHeight = null,
    Object? translationChoice = null,
    Object? themeColor = null,
  }) {
    return _then(_$SettingImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as String,
      numberOfSynonyms: null == numberOfSynonyms
          ? _value.numberOfSynonyms
          : numberOfSynonyms // ignore: cast_nullable_to_non_nullable
              as int,
      numberOfAntonyms: null == numberOfAntonyms
          ? _value.numberOfAntonyms
          : numberOfAntonyms // ignore: cast_nullable_to_non_nullable
              as int,
      enableAdaptiveTheme: null == enableAdaptiveTheme
          ? _value.enableAdaptiveTheme
          : enableAdaptiveTheme // ignore: cast_nullable_to_non_nullable
              as bool,
      openAppCount: null == openAppCount
          ? _value.openAppCount
          : openAppCount // ignore: cast_nullable_to_non_nullable
              as int,
      readingFontSize: null == readingFontSize
          ? _value.readingFontSize
          : readingFontSize // ignore: cast_nullable_to_non_nullable
              as double,
      numberOfEssentialLeft: null == numberOfEssentialLeft
          ? _value.numberOfEssentialLeft
          : numberOfEssentialLeft // ignore: cast_nullable_to_non_nullable
              as int,
      readingFontSizeSliderValue: null == readingFontSizeSliderValue
          ? _value.readingFontSizeSliderValue
          : readingFontSizeSliderValue // ignore: cast_nullable_to_non_nullable
              as double,
      language: null == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryResponseSelectedListVietnamese: null ==
              dictionaryResponseSelectedListVietnamese
          ? _value.dictionaryResponseSelectedListVietnamese
          : dictionaryResponseSelectedListVietnamese // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryResponseSelectedListEnglish: null ==
              dictionaryResponseSelectedListEnglish
          ? _value.dictionaryResponseSelectedListEnglish
          : dictionaryResponseSelectedListEnglish // ignore: cast_nullable_to_non_nullable
              as String,
      translationLanguageTarget: null == translationLanguageTarget
          ? _value.translationLanguageTarget
          : translationLanguageTarget // ignore: cast_nullable_to_non_nullable
              as String,
      windowsWidth: null == windowsWidth
          ? _value.windowsWidth
          : windowsWidth // ignore: cast_nullable_to_non_nullable
              as double,
      windowsHeight: null == windowsHeight
          ? _value.windowsHeight
          : windowsHeight // ignore: cast_nullable_to_non_nullable
              as double,
      translationChoice: null == translationChoice
          ? _value.translationChoice
          : translationChoice // ignore: cast_nullable_to_non_nullable
              as String,
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SettingImpl implements _Setting {
  const _$SettingImpl(
      {required this.themeMode,
      required this.numberOfSynonyms,
      required this.numberOfAntonyms,
      required this.enableAdaptiveTheme,
      required this.openAppCount,
      required this.readingFontSize,
      required this.numberOfEssentialLeft,
      required this.readingFontSizeSliderValue,
      required this.language,
      required this.dictionaryResponseSelectedListVietnamese,
      required this.dictionaryResponseSelectedListEnglish,
      required this.translationLanguageTarget,
      required this.windowsWidth,
      required this.windowsHeight,
      required this.translationChoice,
      required this.themeColor});

  /// Save current theme of this app in this param, it holds string value of [ThemeMode] with value:
  /// ThemeMode.system, ThemeMode.dark, ThemeMode.light
  @override
  final String themeMode;

  /// Number of Synonyms is the number of Synonyms displayed in dictionary
  @override
  final int numberOfSynonyms;

  /// Number of Antonyms is the number of Antonyms displayed in dictionary
  @override
  final int numberOfAntonyms;

  /// Adaptive theme use DynamicTheme package to generate colorScheme
  @override
  final bool enableAdaptiveTheme;

  /// Open app count will trigger a specific function when user use app for a period of time
  @override
  final int openAppCount;

  /// This reading font size used in story reading view
  @override
  final double readingFontSize;

  /// Number of word when practice will be count down and save in this property
  @override
  final int numberOfEssentialLeft;

  /// Hold slider value of reading font size in settings
  @override
  final double readingFontSizeSliderValue;

  /// Language of app, those value : English, Tiếng Việt, System default will be convert
  /// to [Locale('en', 'US')] to change value of the app
  @override
  final String language;

  /// Custom for response in dictionary
  @override
  final String dictionaryResponseSelectedListVietnamese;

  /// Custom for response in dictionary
  @override
  final String dictionaryResponseSelectedListEnglish;

  /// Save target translate language with defined language in , currently support:
  /// englishToVietnamese, vietnameseToEnglish, autoDetect
  @override
  final String translationLanguageTarget;

  /// Hold windows size value
  @override
  final double windowsWidth;

  /// Hold windows size value
  @override
  final double windowsHeight;

  /// The app support two type of translation, using classic dictionary or use AI to
  /// generate answer. That's include: AI, Classic.
  @override
  final String translationChoice;

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  @override
  final int themeColor;

  @override
  String toString() {
    return 'Settings(themeMode: $themeMode, numberOfSynonyms: $numberOfSynonyms, numberOfAntonyms: $numberOfAntonyms, enableAdaptiveTheme: $enableAdaptiveTheme, openAppCount: $openAppCount, readingFontSize: $readingFontSize, numberOfEssentialLeft: $numberOfEssentialLeft, readingFontSizeSliderValue: $readingFontSizeSliderValue, language: $language, dictionaryResponseSelectedListVietnamese: $dictionaryResponseSelectedListVietnamese, dictionaryResponseSelectedListEnglish: $dictionaryResponseSelectedListEnglish, translationLanguageTarget: $translationLanguageTarget, windowsWidth: $windowsWidth, windowsHeight: $windowsHeight, translationChoice: $translationChoice, themeColor: $themeColor)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.numberOfSynonyms, numberOfSynonyms) ||
                other.numberOfSynonyms == numberOfSynonyms) &&
            (identical(other.numberOfAntonyms, numberOfAntonyms) ||
                other.numberOfAntonyms == numberOfAntonyms) &&
            (identical(other.enableAdaptiveTheme, enableAdaptiveTheme) ||
                other.enableAdaptiveTheme == enableAdaptiveTheme) &&
            (identical(other.openAppCount, openAppCount) ||
                other.openAppCount == openAppCount) &&
            (identical(other.readingFontSize, readingFontSize) ||
                other.readingFontSize == readingFontSize) &&
            (identical(other.numberOfEssentialLeft, numberOfEssentialLeft) ||
                other.numberOfEssentialLeft == numberOfEssentialLeft) &&
            (identical(other.readingFontSizeSliderValue,
                    readingFontSizeSliderValue) ||
                other.readingFontSizeSliderValue ==
                    readingFontSizeSliderValue) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.dictionaryResponseSelectedListVietnamese,
                    dictionaryResponseSelectedListVietnamese) ||
                other.dictionaryResponseSelectedListVietnamese ==
                    dictionaryResponseSelectedListVietnamese) &&
            (identical(other.dictionaryResponseSelectedListEnglish,
                    dictionaryResponseSelectedListEnglish) ||
                other.dictionaryResponseSelectedListEnglish ==
                    dictionaryResponseSelectedListEnglish) &&
            (identical(other.translationLanguageTarget,
                    translationLanguageTarget) ||
                other.translationLanguageTarget == translationLanguageTarget) &&
            (identical(other.windowsWidth, windowsWidth) ||
                other.windowsWidth == windowsWidth) &&
            (identical(other.windowsHeight, windowsHeight) ||
                other.windowsHeight == windowsHeight) &&
            (identical(other.translationChoice, translationChoice) ||
                other.translationChoice == translationChoice) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      themeMode,
      numberOfSynonyms,
      numberOfAntonyms,
      enableAdaptiveTheme,
      openAppCount,
      readingFontSize,
      numberOfEssentialLeft,
      readingFontSizeSliderValue,
      language,
      dictionaryResponseSelectedListVietnamese,
      dictionaryResponseSelectedListEnglish,
      translationLanguageTarget,
      windowsWidth,
      windowsHeight,
      translationChoice,
      themeColor);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      __$$SettingImplCopyWithImpl<_$SettingImpl>(this, _$identity);
}

abstract class _Setting implements Settings {
  const factory _Setting(
      {required final String themeMode,
      required final int numberOfSynonyms,
      required final int numberOfAntonyms,
      required final bool enableAdaptiveTheme,
      required final int openAppCount,
      required final double readingFontSize,
      required final int numberOfEssentialLeft,
      required final double readingFontSizeSliderValue,
      required final String language,
      required final String dictionaryResponseSelectedListVietnamese,
      required final String dictionaryResponseSelectedListEnglish,
      required final String translationLanguageTarget,
      required final double windowsWidth,
      required final double windowsHeight,
      required final String translationChoice,
      required final int themeColor}) = _$SettingImpl;

  @override

  /// Save current theme of this app in this param, it holds string value of [ThemeMode] with value:
  /// ThemeMode.system, ThemeMode.dark, ThemeMode.light
  String get themeMode;
  @override

  /// Number of Synonyms is the number of Synonyms displayed in dictionary
  int get numberOfSynonyms;
  @override

  /// Number of Antonyms is the number of Antonyms displayed in dictionary
  int get numberOfAntonyms;
  @override

  /// Adaptive theme use DynamicTheme package to generate colorScheme
  bool get enableAdaptiveTheme;
  @override

  /// Open app count will trigger a specific function when user use app for a period of time
  int get openAppCount;
  @override

  /// This reading font size used in story reading view
  double get readingFontSize;
  @override

  /// Number of word when practice will be count down and save in this property
  int get numberOfEssentialLeft;
  @override

  /// Hold slider value of reading font size in settings
  double get readingFontSizeSliderValue;
  @override

  /// Language of app, those value : English, Tiếng Việt, System default will be convert
  /// to [Locale('en', 'US')] to change value of the app
  String get language;
  @override

  /// Custom for response in dictionary
  String get dictionaryResponseSelectedListVietnamese;
  @override

  /// Custom for response in dictionary
  String get dictionaryResponseSelectedListEnglish;
  @override

  /// Save target translate language with defined language in , currently support:
  /// englishToVietnamese, vietnameseToEnglish, autoDetect
  String get translationLanguageTarget;
  @override

  /// Hold windows size value
  double get windowsWidth;
  @override

  /// Hold windows size value
  double get windowsHeight;
  @override

  /// The app support two type of translation, using classic dictionary or use AI to
  /// generate answer. That's include: AI, Classic.
  String get translationChoice;
  @override

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  int get themeColor;
  @override
  @JsonKey(ignore: true)
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
