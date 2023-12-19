import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/data/data_providers/text_to_speech_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../../domain/domain.dart';

/// Params
class ReadingBlocParams {
  final bool isBottomAppBarVisible;
  final double fontSize;
  final String audioFilePath;
  ReadingBlocParams({
    required this.isBottomAppBarVisible,
    required this.fontSize,
    required this.audioFilePath,
  });
  static ReadingBlocParams init() {
    return ReadingBlocParams(
      isBottomAppBarVisible: true,
      fontSize: Properties.instance.settings.readingFontSize,
      audioFilePath: '',
    );
  }

  ReadingBlocParams copyWith({
    bool? isBottomAppBarVisible,
    double? fontSize,
    String? audioFilePath,
  }) {
    return ReadingBlocParams(
      isBottomAppBarVisible:
          isBottomAppBarVisible ?? this.isBottomAppBarVisible,
      fontSize: fontSize ?? this.fontSize,
      audioFilePath: audioFilePath ?? this.audioFilePath,
    );
  }
}

/// States
abstract class ReadingState {
  ReadingBlocParams params;
  ReadingState({required this.params});
}

class ReadingInitState extends ReadingState {
  ReadingInitState({required super.params});
}

class ReadingSettingsUpdatedState extends ReadingState {
  ReadingSettingsUpdatedState({required super.params});
}

class AudioDownloadingState extends ReadingState {
  AudioDownloadingState({required super.params});
}

class AudioDownloadedState extends ReadingState {
  AudioDownloadedState({required super.params});
}

/// Events
abstract class ReadingEvent {}

class IncreaseFontSize extends ReadingEvent {}

class DecreaseFontSize extends ReadingEvent {}

class ShowBottomAppBar extends ReadingEvent {}

class HideBottomAppBar extends ReadingEvent {}

class InitReadingBloc extends ReadingEvent {}

class DownloadAudio extends ReadingEvent {
  final Story story;
  DownloadAudio({required this.story});
}

/// Bloc
class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  ReadingBloc() : super(ReadingInitState(params: ReadingBlocParams.init())) {
    on<InitReadingBloc>(_initReadingBloc);
    on<IncreaseFontSize>(_increaseFontSize);
    on<DecreaseFontSize>(_decreaseFontSize);
    on<HideBottomAppBar>(_hideBottomAppBar);
    on<ShowBottomAppBar>(_showBottomAppBar);
    on<DownloadAudio>(_downloadAudio);
  }

  FutureOr<void> _initReadingBloc(
      InitReadingBloc event, Emitter<ReadingState> emit) {
    emit(ReadingInitState(params: ReadingBlocParams.init()));
  }

  FutureOr<void> _increaseFontSize(
      IncreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize =
        Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize < 70) {
      emit(ReadingSettingsUpdatedState(
          params: state.params.copyWith(fontSize: state.params.fontSize + 2)));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize + 2);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _decreaseFontSize(
      DecreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize =
        Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize > 10) {
      emit(ReadingSettingsUpdatedState(
          params: state.params.copyWith(
        fontSize: state.params.fontSize - 2,
      )));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize - 2);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _showBottomAppBar(
      ShowBottomAppBar event, Emitter<ReadingState> emit) {
    emit(ReadingSettingsUpdatedState(
        params: state.params.copyWith(isBottomAppBarVisible: true)));
  }

  FutureOr<void> _hideBottomAppBar(
      HideBottomAppBar event, Emitter<ReadingState> emit) {
    emit(ReadingSettingsUpdatedState(
        params: state.params.copyWith(isBottomAppBarVisible: false)));
  }

  FutureOr<void> _downloadAudio(
      DownloadAudio event, Emitter<ReadingState> emit) async {
    emit(AudioDownloadingState(params: state.params));
    final tts = TextToSpeechApiClient();
    final dir = await getApplicationCacheDirectory();
    final filePath =
        join(dir.path, '${event.story.title.removeSpecialCharacters()}.mp3');
    await tts.convertTextToSpeech(
        fromText: event.story.content, toFilePath: filePath);
    emit(AudioDownloadedState(
        params: state.params.copyWith(
      audioFilePath: filePath,
    )));
  }
}
