import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';

class ExpandBubbleButton extends StatelessWidget {
  final Function() onTap;
  const ExpandBubbleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.transparent,
          ],
        ),
      ),
      child: Center(
        child: FilledButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.arrow_drop_down),
          label: Text('More'.i18n),
        ),
      ),
    );
  }
}
