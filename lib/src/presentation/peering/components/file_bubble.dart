import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FileBubble extends StatelessWidget {
  final String downloadUrl;
  final String senderId;
  final String senderName;

  const FileBubble({
    super.key,
    required this.downloadUrl,
    required this.senderId,
    required this.senderName,
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
            mainAxisAlignment:
                FirebaseAuth.instance.currentUser!.uid == senderId
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
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }
}
