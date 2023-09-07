
import 'package:flutter/material.dart';
import '../../../../models/word.dart';
import '../../../commons/expand_bubble_button.dart';
import '../../../commons/word_meaning.dart';
import '../../../commons/word_playback_button.dart';
import '../../../commons/word_pronunciation.dart';
import '../../../commons/word_title.dart';

class DictionaryBubble extends StatefulWidget {
  const DictionaryBubble({
    Key? key,
    required this.isMachine,
    required this.message,
    this.onWordTap,
  }) : super(key: key);

  final bool isMachine;
  final Word message;
  final Function(String)? onWordTap;

  @override
  State<DictionaryBubble> createState() => _DictionaryBubbleState();
}

class _DictionaryBubbleState extends State<DictionaryBubble> {
  bool _isTooLarge = true;
  @override
  void initState() {
    super.initState();

    if (countLine() > 15) {
      setState(() {
        _isTooLarge = true;
      });
    } else {
      setState(() {
        _isTooLarge = false;
      });
    }
  }

  int countLine() {
    if (widget.message.meaning != null) {
      return widget.message.meaning!.split('\n').length;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: widget.isMachine

          /// Machine reply bubble
          ? Padding(
              padding: const EdgeInsets.only(left: 32),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                height: _isTooLarge ? 500 : null,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Stack(
                  children: [
                    /// This widget contains meaning of the word
                    SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                WordTitle(
                                  message: widget.message,
                                  titleColor: Colors.white,
                                ),
                                const SizedBox(
                                  width: 8.0,
                                ),
                                WordPronunciation(message: widget.message),
                                WordPlaybackButton(message: widget.message),
                              ],
                            ),
                            Row(
                              children: [
                                WordMeaning(
                                  message: widget.message,
                                  onWordTap: widget.onWordTap,
                                  highlightColor: Colors.white,
                                  subColor: Colors.white70,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Show ExpandButton when the number of line in Meaning to large.
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _isTooLarge
                            ? ExpandBubbleButton(
                                onTap: () {
                                  setState(
                                    () {
                                      _isTooLarge = !_isTooLarge;
                                    },
                                  );
                                },
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
              ),
            )

          /// User input bubble
          : Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                padding: const EdgeInsets.all(12.0),
                height: _isTooLarge ? 500 : null,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Text(
                  widget.message.word,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
    );
  }
}
