import 'package:flutter/material.dart';

class HeadSentence extends StatelessWidget {
  final List<String> listText;
  final double? fontSize;
  const HeadSentence({
    super.key, required this.listText, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
    color: Theme.of(context).colorScheme.onSurface);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listText.map((text) {
        return Text(text, style: textStyle,);
      }).toList(),
    );
  }
}
