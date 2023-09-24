import 'package:flutter/material.dart';
import '../../data/models/word.dart';
import 'clickable_word/ui/clickable_words.dart';

class WordMeaning extends StatelessWidget {
  const WordMeaning({
    super.key,
    required this.message,
    this.onWordTap,
    this.highlightColor,
    this.subColor,
  });

  final Word message;
  final Function(String)? onWordTap;
  final Color? highlightColor;
  final Color? subColor;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: message.meaning!.split('\n').map((meaningLine) {
          /// Change text style to BOLD to some specific lines with special character in the first line
          final lineSplit = meaningLine.split('-');
          final lineStart = lineSplit.first.trim();
          final lineEnd = lineSplit.sublist(1).join('-');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              lineStart.isNotEmpty
              /// Examples for a word
                  ? ClickableWords(
                      text: lineStart,
                      style: TextStyle(
                        color: subColor ?? Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontStyle: FontStyle.italic
                      ),
                      onWordTap: onWordTap)
                  : Container(),
              lineEnd.isNotEmpty
              /// Word's meaning
                  ? ClickableWords(
                      style: TextStyle(
                        color: highlightColor ?? Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      text: "-$lineEnd",
                      onWordTap: onWordTap)
                  : Container(),
            ],
          );
        }).toList(),
      ),
    );
  }
}
