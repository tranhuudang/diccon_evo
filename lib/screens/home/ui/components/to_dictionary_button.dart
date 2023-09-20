import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../dictionary/ui/dictionary.dart';
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
            builder: (context) => const DictionaryView(),
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
              padding: const EdgeInsets.all(5),
              child: const Icon(Icons.search)),
          const SizedBox(height: 8),
          const Text(
            "Diccon chat-based",
            style: TextStyle(fontSize: 12),
          ),
          Text(
            "Dictionary".i18n,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
