import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../presentation.dart';

class SafetyBubble extends StatelessWidget {
  const SafetyBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(builder: (context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Container(
                constraints: BoxConstraints(
                  maxWidth: 86.sw,
                  minWidth: 28.sw,
                ),
                //height: _isTooLarge ? 500 : null,
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.secondary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12, top: 20, right: 12, bottom: 10),
                    child: SelectableText(
                      'To protect you from unwanted or inappropriate content, we do not display this content to you. Thank you for your understanding, and we apologize for any inconvenience.',
                      style: context.theme.textTheme.bodyMedium
                          ?.copyWith(
                              color: context
                                  .theme.colorScheme.onSecondary),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
