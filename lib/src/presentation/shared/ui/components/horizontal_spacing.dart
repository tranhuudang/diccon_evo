import 'package:flutter/material.dart';

class HorizontalSpacing extends StatelessWidget {
  final double width;

  const HorizontalSpacing({super.key, this.width = 8.0});
  const HorizontalSpacing.small({super.key}) : width = 4.0;
  const HorizontalSpacing.medium({super.key}) : width = 8.0;
  const HorizontalSpacing.large({super.key}) : width = 16.0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
