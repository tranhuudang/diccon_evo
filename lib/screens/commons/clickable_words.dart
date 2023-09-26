import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../extensions/target_platform.dart';

class ClickableWords extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Color? textColor;
  final double? fontSize;
  final Function(String)? onWordTap;

  const ClickableWords({
    super.key,
    required this.text,
    this.onWordTap,
    this.style,
    this.textColor,
    this.fontSize,
  });

  @override
  State<ClickableWords> createState() => _ClickableWordsState();
}

class _ClickableWordsState extends State<ClickableWords> {
  final StreamController<int> _hoverIndexController = StreamController<int>();

  @override
  void dispose() {
    _hoverIndexController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> words = widget.text.split(' ');

    return defaultTargetPlatform.isMobile()
        ?
        // We don't want to change cursor or underline text on mobile
        // Which make the performance decrease a lot
        RichText(
            text: TextSpan(
              children: [
                for (var i = 0; i < words.length; i++)
                  TextSpan(
                    text: '${words[i]} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (widget.onWordTap != null) {
                          widget.onWordTap!(words[i]);
                        }
                      },
                    style: widget.style ??
                        TextStyle(
                          color: widget.textColor ?? Colors.white,
                          fontSize: widget.fontSize,
                        ),
                  ),
              ],
            ),
          )
        : StreamBuilder(
            stream: _hoverIndexController.stream,
            initialData: -1,
            builder: (context, snapshot) {
              return RichText(
                text: TextSpan(
                  children: [
                    for (var i = 0; i < words.length; i++)
                      TextSpan(
                        text: '${words[i]} ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (widget.onWordTap != null) {
                              widget.onWordTap!(words[i]);
                            }
                          },
                        onEnter: (_) {
                          _hoverIndexController.add(i);
                        },
                        onExit: (_) {
                          _hoverIndexController.add(-1);
                        },
                        style: widget.style ??
                            TextStyle(
                              color: widget.textColor ?? Colors.white,
                              fontSize: widget.fontSize,
                              decoration: snapshot.data == i
                                  ? TextDecoration.underline
                                  : TextDecoration.none,
                            ),
                      ),
                  ],
                ),
              );
            },
          );
  }
}
