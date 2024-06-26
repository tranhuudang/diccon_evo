import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/your_peers/ui/components/play_back_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AudioBubble extends StatelessWidget {
  final String fileName;
  final String audioUrl;
  final String senderId;
  final String senderName;

  const AudioBubble({
    Key? key,
    required this.audioUrl,
    required this.senderId,
    required this.senderName,
    required this.fileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: FirebaseAuth.instance.currentUser!.uid == senderId
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(.5)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 2),
          child: Row(
            mainAxisAlignment:
                FirebaseAuth.instance.currentUser!.uid == senderId
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 235,
                  minWidth: 235,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlayBackController(
                    audioUrl: audioUrl,
                    label: '${'Play'.i18n} $fileName',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
