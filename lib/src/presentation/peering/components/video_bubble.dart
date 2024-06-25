import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/peering/components/video_webview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VideoBubble extends StatelessWidget {
  final String senderId;
  final String videoUrl;
  final String senderName;

  const VideoBubble({
    super.key,
    required this.videoUrl,
    required this.senderId, required this.senderName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: FirebaseAuth.instance.currentUser!.uid == senderId
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Text(
          senderName,
          style: context.theme.textTheme.labelSmall?.copyWith(
              color: context.theme.colorScheme.onSurface.withOpacity(.5)),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 6, top: 2),
          child: Row(
            mainAxisAlignment: FirebaseAuth.instance.currentUser!.uid == senderId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.86,
                  minWidth: MediaQuery.of(context).size.width * 0.30,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius:
                      BorderRadius.circular(8), // Replace BorderRadiusMissing
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton.icon(
                    icon: Icon(
                      Icons.play_circle_outline,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoWebView(url: videoUrl),
                        ),
                      );
                    },
                    label: Text(
                      'Watch video',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
