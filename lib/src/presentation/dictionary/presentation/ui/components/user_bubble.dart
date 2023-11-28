import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({
    super.key,
    required this.message, required this.onTap,
  });

  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(right: 32),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondaryContainer,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0.0),
                topRight: Radius.circular(16.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Text(
              message,
              style: context.theme.textTheme.titleMedium?.copyWith(
                  color: context.theme.colorScheme.onSecondaryContainer),
            ),
          ),
        ),
      ),
    );
  }
}
