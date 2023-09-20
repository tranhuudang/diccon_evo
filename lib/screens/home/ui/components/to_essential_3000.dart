import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../essential/ui/essential_3000.dart';
import 'feature_button.dart';

class ToEssentialWordButton extends StatelessWidget {
  const ToEssentialWordButton({
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
          Text(
            Properties.defaultSetting.numberOfEssentialLeft.toString(),
            style: const TextStyle(
                fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "words to learn".i18n,
          ),
          const Spacer(),
          Text(
            "1848 Essential English Words".i18n,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
