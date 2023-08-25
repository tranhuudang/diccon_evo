import 'package:flutter/material.dart';

import '../dictionary/models/word.dart';

class WordTitle extends StatelessWidget {
  final Word message;
  final Color? titleColor;

  const WordTitle({
    super.key,
    required this.message,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      //flex: 8,
      child: Text(
        message.word,
        style: TextStyle(
          color: titleColor ?? Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
    );
  }
}
