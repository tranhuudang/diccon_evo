import 'package:flutter/material.dart';
import '../../../../../common/data/models/word.dart';

class WordPronunciation extends StatelessWidget {
  const WordPronunciation({
    super.key,
    required this.message,
  });

  final Word message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message.pronunciation ?? "",
      style: const TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}