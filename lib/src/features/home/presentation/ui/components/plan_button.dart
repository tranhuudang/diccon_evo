import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';
class PlanButton extends StatelessWidget {
  const PlanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: BorderRadius.circular(16)),
      child: ((Properties.userInfo.uid == "PpvAkcjQnfVDb1i3u2aSW6jLN383") ||
              (Properties.userInfo.uid == "jwRlpB8QJ4MLaub4ka0m2X9dXhC3"))
          ? Text(
              "Made with ❤️ for Thảo",
              style:
                  TextStyle(color: context.theme.colorScheme.onSecondary),
            )
          : Text(
              "BETA",
              style:
                  TextStyle(color: context.theme.colorScheme.onSecondary),
            ),
    );
  }
}
