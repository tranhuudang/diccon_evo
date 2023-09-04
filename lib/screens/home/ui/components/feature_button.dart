import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;
  const FeatureButton({
    super.key,
    required this.onTap, required this.child, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(32),
              onTap: onTap,
              child: Container(
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                height: 180,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: backgroundColor ?? Theme.of(context).cardColor),
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
