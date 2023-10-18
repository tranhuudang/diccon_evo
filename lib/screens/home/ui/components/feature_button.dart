import 'package:flutter/material.dart';

class FeatureButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  final Color? backgroundColor;
  final double? height;
  final EdgeInsets? padding;
  final DecorationImage? image;

  final Color? borderColor;
  const FeatureButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.height, this.image, this.padding, this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: child,
        ),
      ),
    );
  }
}
