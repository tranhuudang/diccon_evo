import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class ClickableWords extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Function(String)? onWordTap;

  const ClickableWords({
    super.key,
    required this.text,
    this.onWordTap,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> words = text.split(' ');

    return defaultTargetPlatform.isMobile()
        ?
        // We don't want to change cursor or underline text on mobile
        // Which make the performance decrease a lot
        RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                for (var i = 0; i < words.length; i++)
                  TextSpan(
                      text: '${words[i]} ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (onWordTap != null) {
                            onWordTap!(words[i]);
                          }
                        },
                      style: style),
              ],
            ),
          )
        : RichText(
            text: TextSpan(
              children: [
                for (var i = 0; i < words.length; i++)
                  TextSpan(
                    text: '${words[i]} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (onWordTap != null) {
                          onWordTap!(words[i]);
                        }
                      },
                    style: style ?? const TextStyle(),
                  ),
              ],
            ),
          );
  }
}
