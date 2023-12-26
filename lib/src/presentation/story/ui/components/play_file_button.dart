import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wavy_slider/wavy_slider.dart';
import '../../../../data/data.dart';

class PlayFileButton extends StatefulWidget {
  const PlayFileButton({super.key, required this.filePath});
  final String filePath;
  @override
  State<PlayFileButton> createState() => _PlayFileButtonState();
}

class _PlayFileButtonState extends State<PlayFileButton> {
  final SoundHandler _player = SoundHandler();
  bool _isPlaying = false;
  bool _isPause = false;
  final _playerPositionController = StreamController<double>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _playerPositionController.close();
    super.dispose();
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
              notPlayingAndNotPausing
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
                                icon: const Icon(Icons.pause_circle_outline),
                              ),
                        IconButton(
                          onPressed: () async {
                            await _player.stop();
                            setState(() {
                              _isPlaying = false;
                              _isPause = false;
                            });
                          },
                          icon: const Icon(Icons.stop_circle_outlined),
                        ),
                      ],
                    ),
              8.height,
              if (notPlayingAndNotPausing) Text('Play story'.i18n),
              // Audio progress
              Visibility(
                visible: isPlayingOrIsPausing ? true : false,
                child: WavySlider(
                  width: 36.screenWidth,
                  value: currentPosition,
                  color: context.theme.colorScheme.primary,
                  waveHeight: 10,
                  waveWidth: 14,
                  onChanged: (value) {
                    _player.seek(seekPoint: value, filePath: widget.filePath);
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
        if (kDebugMode) {
          print('Play file button');
        }
        setState(() {
          _isPlaying = true;
          _isPause = false;
        });
        bool isPlayed = await _player.playFromPath(
            filePath: widget.filePath,
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
      },
      icon: Icon(
        Icons.play_arrow_outlined,
        color: context.theme.colorScheme.tertiary,
      ),
    );
  }
}
