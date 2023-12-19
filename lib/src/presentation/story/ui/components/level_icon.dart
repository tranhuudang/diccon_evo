import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class Tag extends StatelessWidget {
  final String title;
  final Color? color;
  final Color? textColor;
  const Tag({
    super.key,
    required this.title,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: color ?? context.theme.colorScheme.primary),
      child: Text(
        title.upperCaseFirstLetter().i18n,
        style:
            TextStyle(color: textColor ?? context.theme.colorScheme.onPrimary),
      ),
    );
  }
}
