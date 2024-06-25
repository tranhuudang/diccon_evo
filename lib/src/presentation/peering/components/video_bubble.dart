import 'package:diccon_evo/src/presentation/peering/components/video_webview.dart';
import 'package:flutter/material.dart';


class VideoBubble extends StatelessWidget {
  final String videoUrl;

  const VideoBubble({
    super.key,
    required this.videoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
                  Icons.play_circle,
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
                  'Watch Video',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
