import 'package:flutter/material.dart';

class VerticalSpacing extends StatelessWidget {
  final double height;

  const VerticalSpacing({super.key, this.height = 8.0});
  const VerticalSpacing.small({super.key}) : height = 4.0;
  const VerticalSpacing.medium({super.key}) : height = 8.0;
  const VerticalSpacing.large({super.key}) : height = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}
