import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ClickableWords extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Function(String) onWordTap;

  ClickableWords({
    required this.text,
    required this.onWordTap, this.style,
  });

  @override
  _ClickableWordsState createState() => _ClickableWordsState();
}

class _ClickableWordsState extends State<ClickableWords> {
  int _hoverIndex = -1;

  @override
  Widget build(BuildContext context) {
    final List<String> words = widget.text.split(' ');

    return RichText(
      text: TextSpan(
        children: [
          for (var i = 0; i < words.length; i++)
            TextSpan(
              text: '${words[i]} ',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  widget.onWordTap(words[i]);
                },
              onEnter: (_) {
                setState(() {
                  _hoverIndex = i;
                });
              },
              onExit: (_) {
                setState(() {
                  _hoverIndex = -1;
                });
              },
              style: widget.style ?? TextStyle(
                color: Colors.white,
                decoration: _hoverIndex == i ? TextDecoration.underline: TextDecoration.none,
              )
              ,
            ),
        ],
      ),
    );
  }
}
