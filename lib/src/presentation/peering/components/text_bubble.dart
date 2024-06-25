import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextBubble extends StatelessWidget {
  final String text;
  final String senderId;
  const TextBubble({
    super.key,
    required this.text,
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
              child: SelectableText(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
