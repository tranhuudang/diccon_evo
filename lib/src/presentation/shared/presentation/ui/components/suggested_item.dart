import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class SuggestedItem extends StatelessWidget {
  final String title;
  final Function(String)? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  const SuggestedItem({super.key, required this.title, this.onPressed, this.backgroundColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap:  () {
          onPressed!(title);
        },
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? context.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              width: 1,
              color: context.theme.colorScheme.primary,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              title,
              style: TextStyle(color: textColor?? context.theme.textTheme.titleSmall?.color),
            ),
          ),
        ),
      ),
    );
  }
}