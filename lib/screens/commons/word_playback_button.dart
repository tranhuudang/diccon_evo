import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../data/handlers/sound_handler.dart';

class WordPlaybackButton extends StatefulWidget {
  const WordPlaybackButton({super.key, required this.message});
  final String message;
  @override
  State<WordPlaybackButton> createState() => _WordPlaybackButtonState();
}

class _WordPlaybackButtonState extends State<WordPlaybackButton> {
  final _streamController = StreamController<bool>();
  void listenToProgress(Stream<bool> progressStream) {
    progressStream.listen((isDownloaded) {
      _streamController.sink.add(isDownloaded);
      if (kDebugMode) {
        print("the sound track downloaded is $isDownloaded");
      } // You can update your UI or perform actions based on these messages.
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _streamController.stream,
        initialData: true,
        builder: (context, snapshot) {
          return snapshot.data!
              ? IconButton(
                  icon: Icon(
                    Icons.volume_up_sharp,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    final progressStream =
                        SoundHandler(widget.message).playAnyway();
                    listenToProgress(progressStream);
                  },
                  iconSize: 20,
                  splashRadius: 15,
                )
              : const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                );
        });
  }
}
