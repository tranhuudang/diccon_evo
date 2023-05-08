import 'package:diccon_evo/components/expand_bubble_button.dart';
import 'package:diccon_evo/viewModels/sound_handler.dart';
import 'package:diccon_evo/viewModels/word_handler.dart';
import 'package:flutter/material.dart';
import '../models/word.dart';
import 'clickable_words.dart';

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
  _DictionaryBubbleState createState() => _DictionaryBubbleState();
}

class _DictionaryBubbleState extends State<DictionaryBubble> {
  bool _isTooLarge = true;
  @override
  void initState() {
    super.initState();

    if (countLine() > 20) {
      _isTooLarge = true;
    } else {
      _isTooLarge = false;
    }
    setState(() {});
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
          /// This approach used to align the bubble to the left or right
          widget.isMachine ? const Spacer() : Container(),
          Flexible(
            /// Added Flexible widget to able to scale base on form's size
            flex: 5,
            child: Column(
              children: [
                Container(
                  height: _isTooLarge ? 500 : null,
                  decoration: BoxDecoration(
                    color: widget.isMachine ? Colors.blue : Colors.grey[800],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(widget.isMachine ? 16.0 : 0.0),
                      topRight: Radius.circular(widget.isMachine ? 0.0 : 16.0),
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
                                        Text(
                                          widget.message.pronunciation ?? "",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontStyle: FontStyle.italic,
                                          ),
                                        ),
                                        const Spacer(),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: ClickableWords(
                                            text: widget.message.meaning!,
                                            onWordTap: widget.onWordTap!,
                                          ),
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
                      Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Spacer(),
                            /// Show ExpandButton when the number of line in Meaning to large.
                            _isTooLarge
                                ? ExpandBubbleButton(
                                    onTap: () {
                                      setState(() {
                                        _isTooLarge = !_isTooLarge;
                                      });
                                    },
                                  )
                                : Container(),
                          ]),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// This approach used to align the bubble to the left or right
          widget.isMachine ? Container() : const Spacer(),
        ],
      ),
    );
  }
}
