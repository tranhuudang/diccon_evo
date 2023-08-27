
import 'package:flutter/material.dart';

import '../../helpers/sound_handler.dart';
import '../../models/word.dart';

class WordPlaybackButton extends StatelessWidget {
  const WordPlaybackButton({
    super.key,
    required this.message,
  });

  final Word message;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.volume_up_sharp,
      ),
      onPressed: () {
        SoundHandler(message.word).playAnyway();
      },
      iconSize: 20,
      splashRadius: 15,
    );
  }
}