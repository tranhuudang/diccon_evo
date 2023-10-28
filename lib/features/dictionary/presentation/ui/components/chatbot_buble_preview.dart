import 'package:flutter/material.dart';
import 'package:diccon_evo/common/common.dart';

class ChatbotBubblePreview extends StatelessWidget {
  final String textReturn;

  const ChatbotBubblePreview({super.key, required this.textReturn});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            decoration: BoxDecoration(
              color: context.theme.colorScheme.primary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.volume_up, size: 20,color: context.theme.colorScheme.onSecondary),),
                    ],
                  ),
                  Text(textReturn, style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.onSecondary),)
                  // SelectableText(
                  //     answer),
                ],
              ),
            ),
          ),
        ));
  }
}
