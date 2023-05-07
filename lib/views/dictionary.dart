import 'package:diccon_evo/viewModels/word_handler.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../models/word.dart';
import '../components/dictionary_buble.dart';
import '../viewModels/searching.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  _DictionaryViewState createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView>
    with AutomaticKeepAliveClientMixin {
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  final List<DictionaryBubble> _messages = [];

  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatListController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();

  void _handleSubmitted(String searchWord) {
    _textController.clear();
    Word? wordResult = Searching.getDefinition(searchWord);

    var emptyWord = Word(word: searchWord);
    // Add left bubble as user message
    _messages.add(DictionaryBubble(isMachine: false, message: emptyWord));
    // Right bubble represent machine reply
    _messages.add(DictionaryBubble(
      isMachine: true,
      message: wordResult!,
      onWordTap: (clickedWord) {
        clickedWord = WordHandler.removeSpecialCharacters(clickedWord);

        _handleSubmitted(clickedWord);
      },
    ));
    setState(() {});
    _textFieldFocusNode.requestFocus();
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
              child: ListView.builder(
            itemCount: _messages.length,
            controller: _chatListController,
            itemBuilder: (BuildContext context, int index) {
              return _messages[index];
            },
          )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: TextField(
                      focusNode: _textFieldFocusNode,
                      onSubmitted: (value) {
                        _handleSubmitted(value);
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
