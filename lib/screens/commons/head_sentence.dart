import 'package:flutter/material.dart';

class HeadSentence extends StatelessWidget {
  final List<String> listText;
  const HeadSentence({
    super.key, required this.listText,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =  const TextStyle(letterSpacing: .5, fontSize: 36);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listText.map((text) {
        return Text(text, style: textStyle,);
      }).toList(),
    );
  }
}
