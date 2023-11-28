import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class ClickableWords extends StatefulWidget {
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
            textAlign: TextAlign.start,
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
                      style: widget.style),
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
