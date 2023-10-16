import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const SettingSection({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  title ?? '',
                  style:  TextStyle(fontWeight: FontWeight.normal, color: Theme.of(context).colorScheme.onSecondary),
                ),
              ),
            ),
            const SizedBox().largeHeight(),
            Column(
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
