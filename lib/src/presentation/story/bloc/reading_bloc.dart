import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/data/data_providers/text_to_speech_client.dart';
import 'package:diccon_evo/src/data/handlers/file_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../../../domain/domain.dart';

/// Params
class ReadingBlocParams {
  final bool isBottomAppBarVisible;
  final bool isDownloading;
  final bool isDownloaded;
  final double fontSize;
  final String audioFilePath;
  ReadingBlocParams({
    required this.isBottomAppBarVisible,
    required this.isDownloading,
    required this.isDownloaded,
    required this.fontSize,
    required this.audioFilePath,
  });
  static ReadingBlocParams init() {
    return ReadingBlocParams(
      isBottomAppBarVisible: true,
      isDownloading: false,
      isDownloaded: false,
      fontSize: Properties.instance.settings.readingFontSize,
      audioFilePath: '',
    );
  }

  ReadingBlocParams copyWith({
    bool? isBottomAppBarVisible,
    bool? isDownloading,
    bool? isDownloaded,
    double? fontSize,
    String? audioFilePath,
  }) {
    return ReadingBlocParams(
      isBottomAppBarVisible:
          isBottomAppBarVisible ?? this.isBottomAppBarVisible,
      isDownloading: isDownloading ?? this.isDownloading,
      isDownloaded: isDownloaded ?? this.isDownloaded,
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

class ReadingUpdatedState extends ReadingState {
  ReadingUpdatedState({required super.params});
}

/// Events
abstract class ReadingEvent {}

class IncreaseFontSize extends ReadingEvent {}

class DecreaseFontSize extends ReadingEvent {}

class PageScrollingUp extends ReadingEvent {}

class PageScrollingDown extends ReadingEvent {}

class InitReadingBloc extends ReadingEvent {
  final Story story;
  InitReadingBloc({required this.story});
}

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
    on<PageScrollingDown>(_pageScrollingDown);
    on<PageScrollingUp>(_pageScrollingUp);
    on<DownloadAudio>(_downloadAudio);
  }

  FutureOr<void> _initReadingBloc(
      InitReadingBloc event, Emitter<ReadingState> emit) async {
    emit(ReadingInitState(params: ReadingBlocParams.init()));
    // Check if audio file of this story is already downloaded before
    final cacheDir = await getApplicationCacheDirectory();
    String filePath = join(
        cacheDir.path, '${event.story.title.removeSpecialCharacters()}.mp3');
    File audioFile = File(filePath);
    if (await audioFile.exists()) {
      if (kDebugMode) {
        print('Audio of "${event.story.title}" story is exist in cache folder');
      }
      emit(
        ReadingUpdatedState(
          params: state.params.copyWith(
            isDownloaded: true,
            audioFilePath: filePath,
          ),
        ),
      );
    }
  }

  FutureOr<void> _increaseFontSize(
      IncreaseFontSize event, Emitter<ReadingState> emit) {
    double currentReadingFontSize =
        Properties.instance.settings.readingFontSize;
    if (currentReadingFontSize < 70) {
      emit(ReadingUpdatedState(
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
      emit(ReadingUpdatedState(
          params: state.params.copyWith(
        fontSize: state.params.fontSize - 2,
      )));
      Properties.instance.settings = Properties.instance.settings.copyWith(
          readingFontSize: Properties.instance.settings.readingFontSize - 2);
      Properties.instance.saveSettings(Properties.instance.settings);
    }
  }

  FutureOr<void> _pageScrollingUp(
      PageScrollingUp event, Emitter<ReadingState> emit) {
    emit(ReadingUpdatedState(
        params: state.params.copyWith(isBottomAppBarVisible: true)));
  }

  FutureOr<void> _pageScrollingDown(
      PageScrollingDown event, Emitter<ReadingState> emit) {
    emit(
      ReadingUpdatedState(
        params: state.params.copyWith(isBottomAppBarVisible: false),
      ),
    );
  }

  FutureOr<void> _downloadAudio(
      DownloadAudio event, Emitter<ReadingState> emit) async {
    emit(
      ReadingUpdatedState(
        params: state.params.copyWith(isDownloading: true),
      ),
    );
    final tts = TextToSpeechApiClient();
    final dir = await getApplicationCacheDirectory();
    final fileName = '${event.story.title.removeSpecialCharacters()}.mp3';
    final filePath =
        join(dir.path, fileName);
    try {
      if (kDebugMode) {
        print('Downloading audio from github');
      }
      var isDownloadGithubSuccess = await FileHandler(filePath).downloadToResources(
          "${OnlineDirectory.storiesAudioURL}$fileName");
      if (!isDownloadGithubSuccess){
        await tts.convertTextToSpeech(
            fromText: event.story.content, toFilePath: filePath);
      }
    } catch (e) {
      if (kDebugMode) {
        print('[ERROR] Can not download audio file from github, try to convert text to speech using open ai api');
      }
      await tts.convertTextToSpeech(
          fromText: event.story.content, toFilePath: filePath);
    }
    emit(
      ReadingUpdatedState(
        params: state.params.copyWith(
          isDownloaded: true,
          isDownloading: false,
          audioFilePath: filePath,
        ),
      ),
    );
  }
}
