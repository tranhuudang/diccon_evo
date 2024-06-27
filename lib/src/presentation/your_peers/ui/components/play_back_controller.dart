import 'dart:async';
import 'package:diccon_evo/src/data/handlers/handlers.dart';
import 'package:dio/dio.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wavy_slider/wavy_slider.dart';

class PlayBackController extends StatefulWidget {
  const PlayBackController(
      {super.key, required this.audioUrl, this.label = ''});
  final String audioUrl;
  final String label;
  @override
  State<PlayBackController> createState() => _PlayBackControllerState();
}

class _PlayBackControllerState extends State<PlayBackController> {
  final SoundHandler _player = SoundHandler();
  bool _isPlaying = false;
  bool _isPause = false;
  final _playerPositionController = StreamController<double>();
  String? localFilePath;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    _playerPositionController.close();
    super.dispose();
  }

  Future<void> _downloadAudioFile() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final directory = await getApplicationDocumentsDirectory();
      final fileName = widget.audioUrl.split('/').last.split('?').first;
      final filePath = '${directory.path}/$fileName';
      final dio = Dio();
      await dio.download(widget.audioUrl, filePath);
      setState(() {
        localFilePath = filePath;
      });
    } catch (e) {
      DebugLog.error('Error downloading audio file: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool notPlayingAndNotPausing = (_isPlaying == false && _isPause == false);
    bool isPlayingOrIsPausing = (_isPlaying == true || _isPause == true);

    return StreamBuilder<double>(
        initialData: 0,
        stream: _playerPositionController.stream,
        builder: (context, playerPositionSnapshot) {
          final double currentPosition = playerPositionSnapshot.data!;
          return Row(
            children: [
              _isLoading
                  ? const LinearProgressIndicator()
                  : notPlayingAndNotPausing
                      ? buildPlayButton()
                      : Row(
                          children: [
                            (_isPause == true)
                                ? buildPlayButton()
                                : IconButton(
                                    onPressed: () async {
                                      await _player.pause();
                                      setState(() {
                                        _isPlaying = false;
                                        _isPause = true;
                                      });
                                    },
                                    icon: Icon(Icons.pause_circle_outline,
                                        color: context
                                            .theme.colorScheme.onPrimary),
                                  ),
                            IconButton(
                              onPressed: () async {
                                await _player.stop();
                                setState(() {
                                  _isPlaying = false;
                                  _isPause = false;
                                });
                              },
                              icon: Icon(Icons.stop_circle_outlined,
                                  color: context.theme.colorScheme.onPrimary),
                            ),
                          ],
                        ),
              const SizedBox(width: 8),
              if (notPlayingAndNotPausing)
                Text(widget.label,
                    style: context.theme.textTheme.labelLarge
                        ?.copyWith(color: context.theme.colorScheme.onPrimary)),
              // Audio progress
              Visibility(
                visible: isPlayingOrIsPausing,
                child: WavySlider(
                  backgroundColor: Colors.black.withOpacity(.3),
                  width: 100,
                  value: currentPosition,
                  color: context.theme.colorScheme.onPrimary,
                  waveHeight: 8,
                  waveWidth: 12,
                  onChanged: (value) {
                    _player.seek(seekPoint: value, filePath: localFilePath!);
                  },
                ),
              ),
            ],
          );
        });
  }

  IconButton buildPlayButton() {
    return IconButton(
      onPressed: () async {
        if (localFilePath == null) {
          await _downloadAudioFile();
        }
        if (localFilePath != null) {
          setState(() {
            _isPlaying = true;
            _isPause = false;
          });
          bool isPlayed = await _player.playFromPath(
              filePath: localFilePath!,
              onFinished: () async {
                await _player.pause();
                setState(() {
                  _isPlaying = false;
                });
              },
              onPositionChanged: (double positionValue) {
                _playerPositionController.add(positionValue);
              });
          if (kDebugMode) {
            print('isPlay: $isPlayed');
          }
        }
      },
      icon: Icon(
        Icons.play_arrow_outlined,
        color: context.theme.colorScheme.onPrimary,
      ),
    );
  }
}
