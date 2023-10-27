import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const Section({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.primary),
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
