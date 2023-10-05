import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../conversation/ui/conversation.dart';
import 'feature_button.dart';
class ToConversationButton extends StatelessWidget {
  const ToConversationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      backgroundColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ConversationView(),
          ),
        );
      },
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.chat)),
          const SizedBox(height: 4),
           Text(
            "Talk with our bot in".i18n,
            style: const TextStyle(fontSize: 12),
          ),
          const Text(
            "Conversation",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const Text(
            "Space",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
