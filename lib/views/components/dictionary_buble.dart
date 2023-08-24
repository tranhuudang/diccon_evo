import 'package:diccon_evo/views/components/expand_bubble_button.dart';
import 'package:diccon_evo/views/components/word_meaning.dart';
import 'package:diccon_evo/views/components/word_playback_button.dart';
import 'package:diccon_evo/views/components/word_pronunciation.dart';
import 'package:diccon_evo/views/components/word_title.dart';
import 'package:flutter/material.dart';
import '../../models/word.dart';

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
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: widget.isMachine
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 600,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: widget.isMachine
                          ? const EdgeInsets.only(left: 32)
                          : const EdgeInsets.only(right: 32),
                      child: Container(
                        height: _isTooLarge ? 500 : null,
                        decoration: BoxDecoration(
                          color:
                              widget.isMachine ? Colors.blue : Colors.grey[800],
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(widget.isMachine ? 16.0 : 0.0),
                            topRight:
                                Radius.circular(widget.isMachine ? 0.0 : 16.0),
                            bottomLeft: const Radius.circular(16.0),
                            bottomRight: const Radius.circular(16.0),
                          ),
                        ),
                        child: Stack(
                          children: [
                            /// This widget contains meaning of the word
                            SingleChildScrollView(
                              physics: const NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: widget.isMachine
                                    ? Column(
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
                                              WordPronunciation(
                                                  message: widget.message),
                                              WordPlaybackButton(
                                                  message: widget.message),
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
                                      )
                                    :

                                    /// This is user input with different UI
                                    Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                widget.message.word,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8.0,
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
                                //Spacer(),
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
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
