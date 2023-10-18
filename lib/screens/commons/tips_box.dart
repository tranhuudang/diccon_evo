import 'package:flutter/material.dart';

class TipsBox extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  const TipsBox({
    super.key,
    required this.children,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32.0),
        ),
      child: Container(
        padding: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceTint,
                        borderRadius: BorderRadius.circular(16)),
                    child: Text(title!, style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),)),
              ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
