import 'dart:async';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WordPlaybackButton extends StatefulWidget {
  const WordPlaybackButton(
      {super.key, required this.message, this.buttonColor});
  final String message;
  final Color? buttonColor;
  @override
  State<WordPlaybackButton> createState() => _WordPlaybackButtonState();
}

class _WordPlaybackButtonState extends State<WordPlaybackButton> {
  final _downloadController = StreamController<bool>();
  void listenToProgress(Stream<bool> progressStream) {
    progressStream.listen((isDownloaded) {
      _downloadController.sink.add(isDownloaded);
      if (kDebugMode) {
        print("the sound track downloaded is $isDownloaded");
      } // You can update your UI or perform actions based on these messages.
    });
  }

  @override
  void dispose() {
    super.dispose();
    _downloadController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _downloadController.stream,
        initialData: true,
        builder: (context, snapshot) {
          return snapshot.data!
              ? IconButton(
                  icon: Icon(
                    Icons.volume_up_sharp,
                    color: widget.buttonColor ??
                        context.theme.colorScheme.onSecondary,
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
