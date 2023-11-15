import 'package:flutter/material.dart';

class WordTitle extends StatelessWidget {
  final String word;
  final Color? titleColor;

  const WordTitle({
    super.key,
    required this.word,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        word,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
