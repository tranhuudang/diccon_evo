import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';

import '../../../essential/ui/essential.dart';
import 'feature_button.dart';

class ToEssentialWordButton extends StatelessWidget {
  const ToEssentialWordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FeatureButton(
              height: 180,
              backgroundColor: Theme.of(context).primaryColor,
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4].map((index) {
                return Padding(
                  padding: const EdgeInsets.only(
                      top: 20, left: 8, right: 8, bottom: 8),
                  child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).highlightColor,
                      )),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
