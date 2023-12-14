import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class UserBubble extends StatelessWidget {
  const UserBubble({
    super.key,
    required this.message, required this.onTap,
  });

  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return InkWell(
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Container(
                  constraints:  BoxConstraints(
                    maxWidth: 86.sw,
                    minWidth: 28.sw,
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
                    style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.theme.colorScheme.onSecondaryContainer),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
