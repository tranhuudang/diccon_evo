import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ConversationMachineBubble extends StatelessWidget {
  final String content;
  const ConversationMachineBubble({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: 86.sw,
              minWidth: 30.sw,
            ),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.secondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SelectableText(
                content,
                style: context.theme.textTheme.bodyMedium
                    ?.copyWith(color: context.theme.colorScheme.onSecondary),
              ),
            ),
          ),
        ],
      );
    });
  }
}
