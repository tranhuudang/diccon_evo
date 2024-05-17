import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class HeadSentence extends StatelessWidget {
  final List<String> listText;
  final double? fontSize;
  const HeadSentence({
    super.key, required this.listText, this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = context.theme.textTheme.headlineMedium?.copyWith(
    color: context.theme.colorScheme.onSurface, fontWeight: FontWeight.bold);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listText.map((text) {
        return Text(text.i18n, style: textStyle,);
      }).toList(),
    );
  }
}
