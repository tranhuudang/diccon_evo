import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import '../../../../../common/data/models/word.dart';

class WordPronunciation extends StatelessWidget {
  const WordPronunciation({
    super.key,
    required this.message, this.color,
  });

  final Word message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      message.pronunciation != "" ? "/${message.pronunciation}/" : "",
      style: TextStyle(
        color: color?? context.theme.colorScheme.onSurface,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}