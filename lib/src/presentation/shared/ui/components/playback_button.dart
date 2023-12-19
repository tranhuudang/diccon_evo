import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/foundation.dart';
import '../../../../data/data.dart';

class PlaybackButton extends StatefulWidget {
  const PlaybackButton(
      {super.key, required this.message, this.languageCode = 'en-US', this.icon});
  final String message;
  final Widget? icon;
  final String languageCode;
  @override
  State<PlaybackButton> createState() => _PlaybackButtonState();
}

class _PlaybackButtonState extends State<PlaybackButton> {
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
                  icon: widget.icon ?? Icon(
                    Icons.volume_up_sharp,
                    color: context.theme.colorScheme.onSecondary,
                  ),
                  onPressed: () {
                    final progressStream = SoundHandler()
                        .playAnyway( widget.message);
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
