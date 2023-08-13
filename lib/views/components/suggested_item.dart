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
      child: InkWell(
        onTap: onPressed ?? () {},
        child: Container(
         // height: 35,
          decoration: BoxDecoration(
            color: backgroundColor ?? Color(0xFF1A567D),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              title,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}