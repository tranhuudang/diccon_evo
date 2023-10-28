import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class UserBubblePreview extends StatelessWidget {
  final String content;
  const UserBubblePreview({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: [
        Container(
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
            content,
            style: context.theme.textTheme.titleMedium?.copyWith(
                color: context.theme.colorScheme.onSecondaryContainer),
          ),
        ),
      ],
    );
  }
}
