import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadSentence extends StatelessWidget {
  final List<String> listText;
  const HeadSentence({
    super.key, required this.listText,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = GoogleFonts.oxygen(
        textStyle: const TextStyle(letterSpacing: .5, fontSize: 36));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: listText.map((text) {
        return Text(text, style: textStyle,);
      }).toList(),
    );
  }
}
