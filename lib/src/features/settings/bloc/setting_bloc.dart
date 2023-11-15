import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/common/common.dart';

class SettingBlocParams {
  final ThemeMode themeMode;
  final Color accentColor;
  final String language;
  final bool enableAdaptiveTheme;
  final TranslationLanguageTarget translationLanguageTarget;
  SettingBlocParams({
    required this.themeMode,
    required this.accentColor,
    required this.language,
    required this.enableAdaptiveTheme,
    required this.translationLanguageTarget,
  });
  SettingBlocParams copyWith({
    ThemeMode? themeMode,
    Color? accentColor,
    String? language,
    bool? enableAdaptiveTheme,
    TranslationLanguageTarget? translationLanguageTarget,
  }) {
    return SettingBlocParams(
      themeMode: themeMode ?? this.themeMode,
      accentColor: accentColor ?? this.accentColor,
      language: language ?? this.language,
      enableAdaptiveTheme: enableAdaptiveTheme ?? this.enableAdaptiveTheme,
      translationLanguageTarget:
          translationLanguageTarget ?? this.translationLanguageTarget,
    );
  }

  static SettingBlocParams init() {
    final defaultData = Properties.defaultSetting;
    return SettingBlocParams(
        themeMode: defaultData.themeMode.toThemeMode(),
        accentColor: Color(defaultData.themeColor),
        language: defaultData.language,
        enableAdaptiveTheme: false,
        translationLanguageTarget: defaultData.translationLanguageTarget
            .toTranslationLanguageTarget());
  }
}

/// Events
abstract class SettingEvent {}

class EnableAdaptiveThemeColorEvent extends SettingEvent {}

class ChangeThemeModeEvent extends SettingEvent {
  final ThemeMode themeMode;
  ChangeThemeModeEvent({required this.themeMode});
}

class ChangeLanguageEvent extends SettingEvent {
  final String language;
  ChangeLanguageEvent({required this.language});
}

class ChangeThemeColorEvent extends SettingEvent {
  final Color color;
  ChangeThemeColorEvent({required this.color});
}

class ForceTranslateVietnameseToEnglish extends SettingEvent {}

class ForceTranslateEnglishToVietnamese extends SettingEvent {}

class AutoDetectLanguage extends SettingEvent {}

/// States
abstract class SettingState {
  final SettingBlocParams params;
  SettingState({required this.params});
}

class SettingInitial extends SettingState {
  SettingInitial({required super.params});
}

class SettingUpdated extends SettingState {
  SettingUpdated({required super.params});
}

/// Bloc

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial(params: SettingBlocParams.init())) {
    on<ChangeThemeColorEvent>(_userChangeThemeColor);
    on<EnableAdaptiveThemeColorEvent>(_enableAdaptiveThemeColor);
    on<ChangeThemeModeEvent>(_themeModeChanged);
    on<ChangeLanguageEvent>(_languageChanged);
    on<AutoDetectLanguage>(_autoDetectLanguage);
    on<ForceTranslateEnglishToVietnamese>(_forceTranslateEnglishToVietnamese);
    on<ForceTranslateVietnameseToEnglish>(_forceTranslateVietnameseToEnglish);
  }

  FutureOr<void> _languageChanged(
      ChangeLanguageEvent event, Emitter<SettingState> emit) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(language: event.language);
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(language: event.language)));
  }

  FutureOr<void> _userChangeThemeColor(
      ChangeThemeColorEvent event, Emitter<SettingState> emit) {
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(themeColor: event.color.value, enableAdaptiveTheme: false);
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params
            .copyWith(accentColor: event.color, enableAdaptiveTheme: false)));
  }

  FutureOr<void> _enableAdaptiveThemeColor(
      EnableAdaptiveThemeColorEvent event, Emitter<SettingState> emit) {
    Properties.defaultSetting =
        Properties.defaultSetting.copyWith(enableAdaptiveTheme: true);
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(enableAdaptiveTheme: true)));
  }

  FutureOr<void> _themeModeChanged(
      ChangeThemeModeEvent event, Emitter<SettingState> emit) {
    Properties.defaultSetting = Properties.defaultSetting
        .copyWith(themeMode: event.themeMode.toString());
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(themeMode: event.themeMode)));
  }

  FutureOr<void> _autoDetectLanguage(
      AutoDetectLanguage event, Emitter<SettingState> emit) {
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        translationLanguageTarget:
            TranslationLanguageTarget.autoDetect.title());
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(
            translationLanguageTarget: TranslationLanguageTarget.autoDetect)));
  }

  FutureOr<void> _forceTranslateEnglishToVietnamese(
      ForceTranslateEnglishToVietnamese event, Emitter<SettingState> emit) {
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        translationLanguageTarget:
            TranslationLanguageTarget.englishToVietnamese.title());
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(
            translationLanguageTarget:
                TranslationLanguageTarget.englishToVietnamese)));
  }

  FutureOr<void> _forceTranslateVietnameseToEnglish(
      ForceTranslateVietnameseToEnglish event, Emitter<SettingState> emit) {
    Properties.defaultSetting = Properties.defaultSetting.copyWith(
        translationLanguageTarget:
            TranslationLanguageTarget.vietnameseToEnglish.title());
    Properties.saveSettings(Properties.defaultSetting);
    emit(SettingUpdated(
        params: state.params.copyWith(
            translationLanguageTarget:
                TranslationLanguageTarget.vietnameseToEnglish)));
  }
}
