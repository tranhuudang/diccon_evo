import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/string.dart';
import 'package:flutter/material.dart';

class LevelIcon extends StatelessWidget {
  final String level;
  const LevelIcon({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary ),
      child: Text(
        level.upperCaseFirstLetter().i18n, style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
    );
  }
}