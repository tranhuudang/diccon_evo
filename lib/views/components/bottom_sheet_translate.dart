import 'package:diccon_evo/views/components/word_meaning.dart';
import 'package:diccon_evo/views/components/word_playback_button.dart';
import 'package:diccon_evo/views/components/word_pronunciation.dart';
import 'package:diccon_evo/views/components/word_title.dart';
import 'package:flutter/material.dart';
import '../../models/word.dart';
import 'clickable_words.dart';

class BottomSheetTranslation extends StatelessWidget {
  final Word message;
  final Function(String)? onWordTap;
  const BottomSheetTranslation(
      {super.key, required this.message, this.onWordTap});

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    WordTitle(
                      message: message,
                      titleColor: Colors.white,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    WordPronunciation(message: message),
                    WordPlaybackButton(message: message),
                  ],
                ),
                Row(
                  children: [
                    WordMeaning(message: message, onWordTap: onWordTap),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
