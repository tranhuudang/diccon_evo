import 'dart:async';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/properties.dart';

/// Events
abstract class SettingEvent{}

class EnableAdaptiveThemeColorEvent extends SettingEvent{}
class ChangeThemeColorEvent extends SettingEvent {
  final Color color;
  ChangeThemeColorEvent({required this.color});
}

/// States
abstract class SettingState{}
class SettingInitial extends SettingState {}
class AdaptiveThemeColor extends SettingState {}
class ChangeThemeColor extends SettingState {
  final Color color;
  ChangeThemeColor({required this.color});
}

/// Bloc

class SettingBloc extends Bloc<SettingEvent, SettingState>{
  SettingBloc(): super(SettingInitial()){
    on<ChangeThemeColorEvent>(_userChangeThemeColor);
    on<EnableAdaptiveThemeColorEvent>(_enableAdaptiveThemeColor);

  }
  FutureOr<void> _userChangeThemeColor (ChangeThemeColorEvent event, Emitter<SettingState> emit){
    emit(ChangeThemeColor(color: event.color));
    Properties.saveSettings(Properties.defaultSetting.copyWith(themeColor: event.color.value));

  }
  FutureOr<void> _enableAdaptiveThemeColor (EnableAdaptiveThemeColorEvent event, Emitter<SettingState> emit){
    emit(AdaptiveThemeColor());
    Properties.saveSettings(Properties.defaultSetting.copyWith(themeColor: 0));

  }
}