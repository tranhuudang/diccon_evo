import 'package:diccon_evo/src/features/dictionary/presentation/ui/components/classic_bubble.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';

class EnglishToVietnameseClassicBubble extends StatelessWidget {
  const EnglishToVietnameseClassicBubble({
    super.key,
    required this.word,
    this.onWordTap,
  });

  final Word word;
  final Function(String)? onWordTap;

  @override
  Widget build(BuildContext context) {
    return ClassicBubble(
      word: word,
      onWordTap: onWordTap ?? (value) {},
      language: 'en-US',
    );
  }
}