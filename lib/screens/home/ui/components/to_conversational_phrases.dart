import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../../essential/ui/essential_3000.dart';
import 'feature_button.dart';

class ToConversationalPhrasesButton extends StatelessWidget {
  const ToConversationalPhrasesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const EssentialView()));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "939",
            style: TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "essential sentences to master".i18n,
          ),
          const Spacer(),
          Text(
            "Boost your English communication skills with 939 invaluable phrases".i18n,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
