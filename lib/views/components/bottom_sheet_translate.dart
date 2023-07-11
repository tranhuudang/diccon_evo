import 'package:diccon_evo/views/components/expand_bubble_button.dart';
import 'package:diccon_evo/helpers/sound_handler.dart';
import 'package:flutter/material.dart';
import '../../models/word.dart';
import 'clickable_words.dart';

class BottomSheetTranslation extends StatefulWidget {
  const BottomSheetTranslation({
    Key? key,
    required this.message,
    this.onWordTap,
  }) : super(key: key);

  final Word message;
  final Function(String)? onWordTap;

  @override
  _BottomSheetTranslationState createState() => _BottomSheetTranslationState();
}

class _BottomSheetTranslationState extends State<BottomSheetTranslation> {
  @override
  void initState() {
    super.initState();
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
          Flexible(
            /// Added Flexible widget to able to scale base on form's size
            flex: 5,
            child: Column(
              children: [
                Stack(
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
                                  Flexible(
                                    //flex: 8,
                                    child: Text(
                                      widget.message.word,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24.0,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    widget.message.pronunciation ?? "",
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.volume_up_sharp,
                                    ),
                                    onPressed: () {
                                      SoundHandler.playAnyway(
                                          widget.message.word);
                                    },
                                    iconSize: 20,
                                    splashRadius: 15,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: widget.message.meaning!
                                          .split('\n')
                                          .map((meaningLine) {
                                        /// Change text style to BOLD to some specific lines with special character in the first line
                                        final lineSplit =
                                            meaningLine.split('-');
                                        final lineStart =
                                            lineSplit.first.trim();
                                        final lineEnd =
                                            lineSplit.sublist(1).join('-');
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            lineStart.isNotEmpty
                                                ? ClickableWords(
                                                    text: lineStart,
                                                    style: const TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    onWordTap: (value) {
                                                      widget.onWordTap!(value);
                                                    })
                                                : Container(),
                                            lineEnd.isNotEmpty
                                                ? ClickableWords(
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    text: "-$lineEnd",
                                                    onWordTap: (value) {
                                                      widget.onWordTap!(value);
                                                    })
                                                : Container(),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
