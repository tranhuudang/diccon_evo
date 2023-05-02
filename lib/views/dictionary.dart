import 'package:flutter/material.dart';

import '../models/chat_message.dart';
import '../models/message_buble.dart';

class DictionaryView extends StatefulWidget {
  @override
  _DictionaryViewState createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  List<ChatMessage> _messages = [
    ChatMessage(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
      sender: 'John',
    ),
    ChatMessage(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
      sender: 'John',
    ),
    ChatMessage(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
      sender: 'John',
    ),
    ChatMessage(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
      sender: 'John',
    ),
    ChatMessage(
      word: 'Dart',
      pronunciation: '/dɑːt/',
      meaning:
          'a client-optimized language for fast apps on multiple platforms',
      type: 'Noun',
      sender: 'John',
    ),
  ];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatListController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _handleSubmitted(ChatMessage text) {
    _textController.clear();
    setState(() {
      _messages.add(text);
      _listKey.currentState!.insertItem(_messages.length - 1);
      _textFieldFocusNode.requestFocus();
    });
    // Delay the scroll animation until after the list has been updated
    Future.delayed(Duration(milliseconds: 300), () {
      _chatListController.animateTo(
        _chatListController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _chatListController,
              initialItemCount: _messages.length,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                ChatMessage message = _messages[index];

                bool isMe = message.sender == 'John';
                return FadeTransition(
                  opacity: animation,
                  child: MessageBubble(isMe: isMe, message: message),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    focusNode: _textFieldFocusNode,
                    onSubmitted: (value) {
                      _handleSubmitted(
                          ChatMessage(word: value, sender: "Jane"));
                    },
                    decoration: InputDecoration(
                      hintText: "Send a message",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    controller: _textController,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
