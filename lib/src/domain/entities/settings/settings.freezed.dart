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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
  String get dictionarySpecializedVietnamese =>
      throw _privateConstructorUsedError;

  /// Stream for fast, timeBomb for slow
  String get dictionaryEngine => throw _privateConstructorUsedError;

  /// Custom for response in dictionary
  String get dictionarySpecializedEnglish => throw _privateConstructorUsedError;

  /// Save target translate language with defined language in , currently support:
  /// englishToVietnamese, vietnameseToEnglish, autoDetect
  String get translationLanguageTarget => throw _privateConstructorUsedError;

  /// Hold windows size value
  double get windowsWidth => throw _privateConstructorUsedError;

  /// Hold windows size value
  double get windowsHeight => throw _privateConstructorUsedError;

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  int get themeColor => throw _privateConstructorUsedError;

  /// Save selected tab path for desktop device
  String get selectedTab => throw _privateConstructorUsedError;

  /// Working in login screen, it true when user decide to using the app without login
  bool get continueWithoutLogin => throw _privateConstructorUsedError;

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
      String dictionarySpecializedVietnamese,
      String dictionaryEngine,
      String dictionarySpecializedEnglish,
      String translationLanguageTarget,
      double windowsWidth,
      double windowsHeight,
      int themeColor,
      String selectedTab,
      bool continueWithoutLogin});
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
    Object? dictionarySpecializedVietnamese = null,
    Object? dictionaryEngine = null,
    Object? dictionarySpecializedEnglish = null,
    Object? translationLanguageTarget = null,
    Object? windowsWidth = null,
    Object? windowsHeight = null,
    Object? themeColor = null,
    Object? selectedTab = null,
    Object? continueWithoutLogin = null,
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
      dictionarySpecializedVietnamese: null == dictionarySpecializedVietnamese
          ? _value.dictionarySpecializedVietnamese
          : dictionarySpecializedVietnamese // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryEngine: null == dictionaryEngine
          ? _value.dictionaryEngine
          : dictionaryEngine // ignore: cast_nullable_to_non_nullable
              as String,
      dictionarySpecializedEnglish: null == dictionarySpecializedEnglish
          ? _value.dictionarySpecializedEnglish
          : dictionarySpecializedEnglish // ignore: cast_nullable_to_non_nullable
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
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as String,
      continueWithoutLogin: null == continueWithoutLogin
          ? _value.continueWithoutLogin
          : continueWithoutLogin // ignore: cast_nullable_to_non_nullable
              as bool,
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
      String dictionarySpecializedVietnamese,
      String dictionaryEngine,
      String dictionarySpecializedEnglish,
      String translationLanguageTarget,
      double windowsWidth,
      double windowsHeight,
      int themeColor,
      String selectedTab,
      bool continueWithoutLogin});
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
    Object? dictionarySpecializedVietnamese = null,
    Object? dictionaryEngine = null,
    Object? dictionarySpecializedEnglish = null,
    Object? translationLanguageTarget = null,
    Object? windowsWidth = null,
    Object? windowsHeight = null,
    Object? themeColor = null,
    Object? selectedTab = null,
    Object? continueWithoutLogin = null,
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
      dictionarySpecializedVietnamese: null == dictionarySpecializedVietnamese
          ? _value.dictionarySpecializedVietnamese
          : dictionarySpecializedVietnamese // ignore: cast_nullable_to_non_nullable
              as String,
      dictionaryEngine: null == dictionaryEngine
          ? _value.dictionaryEngine
          : dictionaryEngine // ignore: cast_nullable_to_non_nullable
              as String,
      dictionarySpecializedEnglish: null == dictionarySpecializedEnglish
          ? _value.dictionarySpecializedEnglish
          : dictionarySpecializedEnglish // ignore: cast_nullable_to_non_nullable
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
      themeColor: null == themeColor
          ? _value.themeColor
          : themeColor // ignore: cast_nullable_to_non_nullable
              as int,
      selectedTab: null == selectedTab
          ? _value.selectedTab
          : selectedTab // ignore: cast_nullable_to_non_nullable
              as String,
      continueWithoutLogin: null == continueWithoutLogin
          ? _value.continueWithoutLogin
          : continueWithoutLogin // ignore: cast_nullable_to_non_nullable
              as bool,
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
      required this.dictionarySpecializedVietnamese,
      required this.dictionaryEngine,
      required this.dictionarySpecializedEnglish,
      required this.translationLanguageTarget,
      required this.windowsWidth,
      required this.windowsHeight,
      required this.themeColor,
      required this.selectedTab,
      required this.continueWithoutLogin});

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
  final String dictionarySpecializedVietnamese;

  /// Stream for fast, timeBomb for slow
  @override
  final String dictionaryEngine;

  /// Custom for response in dictionary
  @override
  final String dictionarySpecializedEnglish;

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

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  @override
  final int themeColor;

  /// Save selected tab path for desktop device
  @override
  final String selectedTab;

  /// Working in login screen, it true when user decide to using the app without login
  @override
  final bool continueWithoutLogin;

  @override
  String toString() {
    return 'Settings(themeMode: $themeMode, numberOfSynonyms: $numberOfSynonyms, numberOfAntonyms: $numberOfAntonyms, enableAdaptiveTheme: $enableAdaptiveTheme, openAppCount: $openAppCount, readingFontSize: $readingFontSize, numberOfEssentialLeft: $numberOfEssentialLeft, readingFontSizeSliderValue: $readingFontSizeSliderValue, language: $language, dictionarySpecializedVietnamese: $dictionarySpecializedVietnamese, dictionaryEngine: $dictionaryEngine, dictionarySpecializedEnglish: $dictionarySpecializedEnglish, translationLanguageTarget: $translationLanguageTarget, windowsWidth: $windowsWidth, windowsHeight: $windowsHeight, themeColor: $themeColor, selectedTab: $selectedTab, continueWithoutLogin: $continueWithoutLogin)';
  }

  @override
  bool operator ==(Object other) {
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
            (identical(other.dictionarySpecializedVietnamese,
                    dictionarySpecializedVietnamese) ||
                other.dictionarySpecializedVietnamese ==
                    dictionarySpecializedVietnamese) &&
            (identical(other.dictionaryEngine, dictionaryEngine) ||
                other.dictionaryEngine == dictionaryEngine) &&
            (identical(other.dictionarySpecializedEnglish,
                    dictionarySpecializedEnglish) ||
                other.dictionarySpecializedEnglish ==
                    dictionarySpecializedEnglish) &&
            (identical(other.translationLanguageTarget, translationLanguageTarget) ||
                other.translationLanguageTarget == translationLanguageTarget) &&
            (identical(other.windowsWidth, windowsWidth) ||
                other.windowsWidth == windowsWidth) &&
            (identical(other.windowsHeight, windowsHeight) ||
                other.windowsHeight == windowsHeight) &&
            (identical(other.themeColor, themeColor) ||
                other.themeColor == themeColor) &&
            (identical(other.selectedTab, selectedTab) ||
                other.selectedTab == selectedTab) &&
            (identical(other.continueWithoutLogin, continueWithoutLogin) ||
                other.continueWithoutLogin == continueWithoutLogin));
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
      dictionarySpecializedVietnamese,
      dictionaryEngine,
      dictionarySpecializedEnglish,
      translationLanguageTarget,
      windowsWidth,
      windowsHeight,
      themeColor,
      selectedTab,
      continueWithoutLogin);

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
      required final String dictionarySpecializedVietnamese,
      required final String dictionaryEngine,
      required final String dictionarySpecializedEnglish,
      required final String translationLanguageTarget,
      required final double windowsWidth,
      required final double windowsHeight,
      required final int themeColor,
      required final String selectedTab,
      required final bool continueWithoutLogin}) = _$SettingImpl;

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
  String get dictionarySpecializedVietnamese;
  @override

  /// Stream for fast, timeBomb for slow
  String get dictionaryEngine;
  @override

  /// Custom for response in dictionary
  String get dictionarySpecializedEnglish;
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

  /// Hold primary color for the app, it can be generate to other colors later to
  /// create colorScheme
  int get themeColor;
  @override

  /// Save selected tab path for desktop device
  String get selectedTab;
  @override

  /// Working in login screen, it true when user decide to using the app without login
  bool get continueWithoutLogin;
  @override
  @JsonKey(ignore: true)
  _$$SettingImplCopyWith<_$SettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
