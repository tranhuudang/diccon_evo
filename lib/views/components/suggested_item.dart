import 'dart:ui';
import 'package:flutter/material.dart';

class SuggestedItem extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const SuggestedItem({super.key, required this.title, this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey[600],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextButton(
            onPressed: onPressed ?? () {},
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}