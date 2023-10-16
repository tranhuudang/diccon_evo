import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/properties.dart';

/// Events
abstract class SettingEvent {}

class EnableAdaptiveThemeColorEvent extends SettingEvent {}

class ChangeThemeModeEvent extends SettingEvent {
  final ThemeMode themeMode;
  ChangeThemeModeEvent({required this.themeMode});
}

class ChangeThemeColorEvent extends SettingEvent {
  final Color color;
  ChangeThemeColorEvent({required this.color});
}

/// States
abstract class SettingState {}

class SettingInitial extends SettingState {}

class AdaptiveThemeColor extends SettingState {}

class ThemeModeChanged extends SettingState {
  final ThemeMode themeMode;
  ThemeModeChanged({required this.themeMode});
}

class ChangeThemeColor extends SettingState {
  final Color color;
  ChangeThemeColor({required this.color});
}

/// Bloc

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(SettingInitial()) {
    on<ChangeThemeColorEvent>(_userChangeThemeColor);
    on<EnableAdaptiveThemeColorEvent>(_enableAdaptiveThemeColor);
    on<ChangeThemeModeEvent>(_themeModeChanged);
  }
  FutureOr<void> _userChangeThemeColor(
      ChangeThemeColorEvent event, Emitter<SettingState> emit) {
    Properties.saveSettings(
        Properties.defaultSetting.copyWith(themeColor: event.color.value));
    emit(ChangeThemeColor(color: event.color));
  }

  FutureOr<void> _enableAdaptiveThemeColor(
      EnableAdaptiveThemeColorEvent event, Emitter<SettingState> emit) {
    Properties.saveSettings(Properties.defaultSetting.copyWith(themeColor: 0));

    emit(AdaptiveThemeColor());
  }

  FutureOr<void> _themeModeChanged(
      ChangeThemeModeEvent event, Emitter<SettingState> emit) {
    Properties.saveSettings(Properties.defaultSetting
        .copyWith(themeMode: event.themeMode.toString()));

    emit(ThemeModeChanged(themeMode: event.themeMode));
  }
}
