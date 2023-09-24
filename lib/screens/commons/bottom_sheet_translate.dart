
import 'package:diccon_evo/screens/commons/word_meaning.dart';
import 'package:diccon_evo/screens/commons/word_playback_button.dart';
import 'package:diccon_evo/screens/commons/word_pronunciation.dart';
import 'package:diccon_evo/screens/commons/word_title.dart';
import 'package:flutter/material.dart';
import '../../data/models/word.dart';

class BottomSheetTranslation extends StatelessWidget {
  final Word message;
  final Function(String)? onWordTap;
  const BottomSheetTranslation(
      {super.key, required this.message, this.onWordTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                    WordMeaning(
                      message: message,
                      onWordTap: onWordTap,
                      highlightColor: Colors.white,
                      subColor: Colors.white70,
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
