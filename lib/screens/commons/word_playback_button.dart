import 'package:flutter/material.dart';
import '../../data/handlers/sound_handler.dart';

class WordPlaybackButton extends StatelessWidget {
  const WordPlaybackButton({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.volume_up_sharp,
      ),
      onPressed: () {
        SoundHandler(message).playAnyway();
      },
      iconSize: 20,
      splashRadius: 15,
    );
  }
}
