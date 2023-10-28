import 'package:flutter/material.dart';

import '../../common/data/models/word.dart';


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
