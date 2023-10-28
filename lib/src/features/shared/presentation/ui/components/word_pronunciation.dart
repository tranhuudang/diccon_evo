import 'package:diccon_evo/src/common/common.dart';
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
      "/${message.pronunciation}/" ?? "",
      style: TextStyle(
        color: context.theme.colorScheme.onSurface,
        fontStyle: FontStyle.italic,
      ),
    );
  }
}