import 'package:diccon_evo/components/header_box.dart';
import 'package:diccon_evo/components/welcome_box.dart';
import 'package:diccon_evo/viewModels/file_handler.dart';
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
  final List<Widget> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatListController = ScrollController();
  final FocusNode _textFieldFocusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _messages.add(WelcomeBox());

    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _handleSubmitted(String searchWord) async {
    _textController.clear();

    var emptyWord = Word(word: searchWord);

    /// Add left bubble as user message
    _messages.add(DictionaryBubble(isMachine: false, message: emptyWord));
    try {
      /// This line is the skeleton of finding word in dictionary
      Word? wordResult = Searching.getDefinition(searchWord);

      /// Right bubble represent machine reply
      _messages.add(DictionaryBubble(
        isMachine: true,
        message: wordResult!,
        onWordTap: (clickedWord) {
          clickedWord = WordHandler.removeSpecialCharacters(clickedWord);
          _handleSubmitted(clickedWord);
        },
      ));

      /// Add found word to history file
      await FileHandler.saveToHistory(wordResult);
    } catch (e) {
      /// When a word can't be found. It'll show a message to notify that error.
      _messages.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Text("Sorry, we couldn't find this word at this time.")
        ],
      ));
    }
    setState(() {});
    _textFieldFocusNode.requestFocus();

    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatListController.animateTo(
        _chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
        HeaderBox(title: Global.DICTIONARY, icon: Icons.search,),
          Expanded(
            /// List of all bubble messages on a conversation
            child: ListView.builder(
              itemCount: _messages.length,
              controller: _chatListController,
              itemBuilder: (BuildContext context, int index) {
                return _messages[index];
              },
            ),
          ),

          /// TextField for user to enter their words
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
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
