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

  bool _isExpanded = false;
@override
void initState() {
    // TODO: implement initState
    super.initState();

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
          widget.isMachine ? const Spacer() : Container(),
          Flexible(
            // Added Flexible widget to able to scale base on form's size
            flex: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Container(
                height: _isExpanded ? null : null,
                decoration: BoxDecoration(
                  color: widget.isMachine ? Colors.blue : Colors.grey[800],


                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.isMachine ? 16.0 : 0.0),
                    topRight: Radius.circular(widget.isMachine ? 0.0 : 16.0),
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
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
                                Spacer(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.volume_up_sharp,
                                  ),
                                  onPressed: () {
                                    SoundHandler.playOnline(
                                        widget.message.word);
                                  },
                                  iconSize: 20,
                                  splashRadius: 15,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      // This is user input UI
                      Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  widget.message.word,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                              ],
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ),
          widget.isMachine ? Container() : const Spacer(),
        ],
      ),
    );
  }
}
