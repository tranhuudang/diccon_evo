import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class StoryClickableWords extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final Function(String word, String sentence)? onWordTap;

  const StoryClickableWords({
    super.key,
    required this.text,
    this.onWordTap,
    this.style,
  });

  @override
  State<StoryClickableWords> createState() => _StoryClickableWordsState();
}

class _StoryClickableWordsState extends State<StoryClickableWords> {
  // New method to find the sentence containing the clicked word

  String getSentenceContainingWord(
      String clickedWord, List<String> words, int clickedWordIndex) {
    bool isSentenceBoundary(String word) {
      return (word.endsWith('.') &&
          !word.endsWith('Mrs.') &&
          !word.endsWith('Mr.'));
    }

    // Ensure the clicked word at the given index matches the clicked word
    if (clickedWordIndex < 0 ||
        clickedWordIndex >= words.length ||
        words[clickedWordIndex] != clickedWord) {
      return '';
    }

    // Find the boundaries of the sentence
    int start = clickedWordIndex;
    int end = clickedWordIndex;

    // Move backwards to find the start of the sentence
    while (start > 0 && !isSentenceBoundary(words[start - 1])) {
      start--;
    }

    // Move forwards to find the end of the sentence
    while (end < words.length - 1 && !isSentenceBoundary(words[end])) {
      end++;
    }

    // Include the end boundary word in the sentence
    if (end < words.length && isSentenceBoundary(words[end])) {
      end++;
    } else if (end == words.length - 1 && !isSentenceBoundary(words[end])) {
      // If at the end of the list and the last word is not a sentence boundary, include it
      end++;
    }

    // Extract the sentence
    return words.sublist(start, end).join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> words = widget.text.split(' ');
    return defaultTargetPlatform.isMobile()
        ? RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                for (var i = 0; i < words.length; i++)
                  TextSpan(
                      text: '${words[i]} ',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          if (widget.onWordTap != null) {
                            String sentence =
                                getSentenceContainingWord(words[i], words, i);
                            widget.onWordTap!(words[i], sentence);
                            // New: Get the sentence and do something with it
                            if (kDebugMode) {
                              print(
                                  'Clicked word: ${words[i]}, Sentence: $sentence');
                            }
                          }
                        },
                      style: widget.style),
              ],
            ),
          )
        : RichText(
            text: TextSpan(
              children: [
                for (var i = 0; i < words.length; i++)
                  TextSpan(
                    text: '${words[i]} ',
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        if (widget.onWordTap != null) {
                          String sentence =
                              getSentenceContainingWord(words[i], words, i);
                          widget.onWordTap!(words[i], sentence);
                          if (kDebugMode) {
                            print(
                                'Clicked word: ${words[i]}, Sentence: $sentence');
                          }
                        }
                      },
                    style: widget.style ?? const TextStyle(),
                  ),
              ],
            ),
          );
  }
}
