import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FileBubble extends StatelessWidget {
  final String downloadUrl;
  final String senderId;
  const FileBubble({
    super.key,
    required this.downloadUrl,
    required this.senderId,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
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
                      Icons.download_for_offline_outlined,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    onPressed: () {
                      // Implement download functionality
                    },
                    label: Text(
                      'Download',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  )))
        ],
      ),
    );
  }
}
