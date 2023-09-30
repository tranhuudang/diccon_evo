import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../conversation/ui/conversation.dart';
import 'feature_button.dart';
class ToDictionaryButton extends StatelessWidget {
  const ToDictionaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
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
          const SizedBox(height: 8),
          const Text(
            "Talk with our bot in",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "Conversation".i18n,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            "Space".i18n,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
