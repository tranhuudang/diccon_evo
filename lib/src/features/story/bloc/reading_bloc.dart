import 'dart:async';

import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// States
class ReadingState {
  bool isBottomAppBarVisible;
  double fontSize;
  ReadingState({required this.fontSize, required this.isBottomAppBarVisible});

  factory ReadingState.init() {
    return ReadingState(
        fontSize: Properties.instance.settings.readingFontSize,
        isBottomAppBarVisible: true);
  }
}

class ReadingUpdatedState extends ReadingState {
  ReadingUpdatedState(
      {required super.fontSize, required super.isBottomAppBarVisible});
}

/// Events
abstract class ReadingEvent {}

class IncreaseFontSize extends ReadingEvent {}

class DecreaseFontSize extends ReadingEvent {}

class ShowBottomAppBar extends ReadingEvent {}

class HideBottomAppBar extends ReadingEvent {}

/// Bloc
class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  ReadingBloc() : super(ReadingState.init()) {
    on<IncreaseFontSize>(_increaseFontSize);
    on<DecreaseFontSize>(_decreaseFontSize);
    on<HideBottomAppBar>(_hideBottomAppBar);
    on<ShowBottomAppBar>(_showBottomAppBar);
  }
  FutureOr<void> _increaseFontSize(
      IncreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize = Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize < 70) {
      emit(ReadingUpdatedState(
          fontSize: state.fontSize + 1,
          isBottomAppBarVisible: state.isBottomAppBarVisible));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize + 1);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _decreaseFontSize(
      DecreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize = Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize > 8) {
      emit(ReadingUpdatedState(
          fontSize: state.fontSize - 1,
          isBottomAppBarVisible: state.isBottomAppBarVisible));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize - 1);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _showBottomAppBar(
      ShowBottomAppBar event, Emitter<ReadingState> emit) {
    emit(ReadingUpdatedState(
        fontSize: state.fontSize, isBottomAppBarVisible: true));
  }

  FutureOr<void> _hideBottomAppBar(
      HideBottomAppBar event, Emitter<ReadingState> emit) {
    emit(ReadingUpdatedState(
        fontSize: state.fontSize, isBottomAppBarVisible: false));
  }
}
