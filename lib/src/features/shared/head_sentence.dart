import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class HeadSentence extends StatelessWidget {
  final List<String> listText;
  final double? fontSize;
  const HeadSentence({
    super.key, required this.listText, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = context.theme.textTheme.headlineLarge?.copyWith(
    color: context.theme.colorScheme.onSurface);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listText.map((text) {
        return Text(text, style: textStyle,);
      }).toList(),
    );
  }
}
