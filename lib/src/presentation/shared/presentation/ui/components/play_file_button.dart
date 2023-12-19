import 'dart:async';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import '../../../../../data/data.dart';

class PlayFileButton extends StatefulWidget {
  const PlayFileButton({super.key, required this.filePath});
  final String filePath;
  @override
  State<PlayFileButton> createState() => _PlayFileButtonState();
}

class _PlayFileButtonState extends State<PlayFileButton> {
  SoundHandler player = SoundHandler();
  final isPlayingController = StreamController<bool>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: isPlayingController.stream,
      initialData: false,
      builder: (context, isPlayingSnapshot) {
        return
          (isPlayingSnapshot.data! == false) ?
          IconButton(
            onPressed: () async {
              if (kDebugMode) {
                print('Play file button');
              }
              isPlayingController.add(true);
              bool isPlayed = await player.playFromPath(widget.filePath);
              if (kDebugMode) {
                print('isPlay: $isPlayed');
              }
            },
            icon: const Icon(Icons.play_arrow_outlined),):
          IconButton(
            onPressed: () async {

              await player.pause();
              isPlayingController.add(false );

            },
            icon: const Icon(Icons.pause_circle_outline),)
        ;
      }
    );
  }
}
