import 'dart:ui';
import 'package:flutter/material.dart';

class SuggestedItem extends StatelessWidget {
  final String title;
  final Function(String)? onPressed;
  final Color? backgroundColor;
  const SuggestedItem({super.key, required this.title, this.onPressed, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap:  () {
          onPressed!(title);
        },
        child: Container(
         // height: 35,
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              title,
              style:  TextStyle(color: Theme.of(context).textTheme.titleSmall?.color),
            ),
          ),
        ),
      ),
    );
  }
}