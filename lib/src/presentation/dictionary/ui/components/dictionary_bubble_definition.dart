import 'package:flutter/material.dart';

class DictionaryBubbleDefinition extends StatelessWidget {
  final String word;
  final String translation;
  const DictionaryBubbleDefinition(
      {super.key, required this.word, required this.translation});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Text(translation),
    );
  }
}
