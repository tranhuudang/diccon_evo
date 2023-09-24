import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;
  final double? height;
  const FeatureButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(33),
                border: Border.all(
                  color: Theme.of(context).splashColor,
                ),
            color: backgroundColor ?? Theme.of(context).cardColor),
        child: child,
      ),
    );
  }
}
