import 'package:flutter/material.dart';
import '../models/word.dart';

class DictionaryBubble extends StatelessWidget {
  const DictionaryBubble({
    Key? key,
    required this.isMe,
    required this.message,
  }) : super(key: key);

  final bool isMe;
  final Word message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          isMe ? const Spacer() : Container(),
          Flexible( // Added Flexible widget to able to scale base on form's size
            flex: 5,
            child: Card(
              color: isMe ? Colors.blue : Colors.grey[800],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isMe ? 16.0 : 0.0),
                  topRight: Radius.circular(isMe ? 0.0 : 16.0),
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              message.word,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              message.pronunciation ?? "",
                              style: TextStyle(
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.volume_up_sharp,
                              ),
                              onPressed: () {
                                // handle button press here
                              },
                              iconSize: 20,
                              splashRadius: 15,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          children: [
                            Text(
                              message.type ?? "",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                message.meaning ?? "",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          isMe ? Container() : const Spacer(),

        ],
      ),
    );
  }
}
