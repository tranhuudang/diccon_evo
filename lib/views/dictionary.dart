import 'package:diccon_evo/services/thesaurus_service.dart';
import 'package:diccon_evo/views/components/header.dart';
import 'package:diccon_evo/views/components/welcome_box.dart';
import 'package:diccon_evo/helpers/file_handler.dart';
import 'package:diccon_evo/repositories/thesaurus_repository.dart';
import 'package:diccon_evo/helpers/word_handler.dart';
import 'package:diccon_evo/views/word_history.dart';
import 'package:flutter/foundation.dart';
import 'package:translator/translator.dart';
import 'package:flutter/material.dart';

import '../views/components/brick_wall_buttons.dart';
import '../global.dart';
import '../models/word.dart';
import '../views/components/dictionary_buble.dart';
import '../helpers/platform_check.dart';
import '../helpers/searching.dart';

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

  final translator = GoogleTranslator();
  ThesaurusRepository thesaurusRepository = ThesaurusRepository();
  late final ThesaurusService thesaurusService;
  late List<String> _listSynonyms = [];
  late List<String> _listAntonyms = [];
  bool hasImages = false;
  bool hasAntonyms = false;
  bool hasSynonyms = false;
  bool needCorrector = false;

  @override
  void initState() {
    // TODO: implement initState
    thesaurusService = ThesaurusService(thesaurusRepository);
    _messages.add(WelcomeBox());

    super.initState();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetSuggestion() {
    setState(() {
      hasImages = false;
      hasAntonyms = false;
      hasSynonyms = false;
      needCorrector = false;
    });
  }

  Future<Translation> translate(String word) async {
    return await translator.translate(word, from: 'auto', to: 'vi');
  }

  void scrollToBottom() {
    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      _chatListController.animateTo(
        _chatListController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _handleSubmitted(String searchWord) async {
    _textController.clear();
    resetSuggestion();
    Word? wordResult;
    var emptyWord = Word(word: searchWord);

    /// Add left bubble as user message
    _messages.add(DictionaryBubble(isMachine: false, message: emptyWord));
    try {
      /// This line is the skeleton of finding word in dictionary
      wordResult = Searching.getDefinition(searchWord);
      if (wordResult != null) {
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
        await FileHandler.saveWordToHistory(wordResult);

        /// Get and add list synonyms to message box
        _listSynonyms = thesaurusService.getSynonyms(searchWord);
        _listAntonyms = thesaurusService.getAntonyms(searchWord);
        if (_listSynonyms.isNotEmpty) {
          setState(() {
            hasSynonyms = true;
          });
        }
        if (_listAntonyms.isNotEmpty) {
          setState(() {
            hasAntonyms = true;
          });
        }
      } else {
        await translate(searchWord).then((translatedWord) {
          _messages.add(DictionaryBubble(
            isMachine: true,
            message: Word(word: searchWord, meaning: translatedWord.text),
            onWordTap: (clickedWord) {
              clickedWord = WordHandler.removeSpecialCharacters(clickedWord);
              _handleSubmitted(clickedWord);
            },
          ));
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception is thrown when searching in dictionary");
      }

      /// When a word can't be found. It'll show a message to notify that error.
      _messages.add(const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text("Sorry, we couldn't find this word at this time.")],
      ));
    }
    setState(() {});


    /// Delay the scroll animation until after the list has been updated
    scrollToBottom();
    if (PlatformCheck.isMobile()) {
      // Remove focus out of TextField in DictionaryView
      Global.textFieldFocusNode.unfocus();
    } else {
      // On desktop we request focus, not on mobile
      Global.textFieldFocusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: Header(
        title: Global.DICTIONARY,
        icon: Icons.search,
        actions: [
          IconButton(
              onPressed: () {
                // Remove focus out of TextField in DictionaryView
                Global.textFieldFocusNode.unfocus();
                Navigator.push(context, MaterialPageRoute(builder: (context) => HistoryView()));
              },
              icon: const Icon(Icons.history))
        ],
      ),
      body: Column(
        children: [
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
          Align(
            alignment: Alignment.centerLeft,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    needCorrector
                        ? const SuggestedItem(
                            title: 'Corrector',
                            backgroundColor: Colors.orange,
                          )
                        : Container(),
                    hasSynonyms
                        ? SuggestedItem(
                            onPressed: () {
                              setState(() {
                                _messages.add(BrickWallButtons(
                                  stringList: _listSynonyms,
                                  itemOnPressed: (clickedWord) {
                                    clickedWord =
                                        WordHandler.removeSpecialCharacters(
                                            clickedWord);
                                    _handleSubmitted(clickedWord);
                                  },
                                ));
                                hasSynonyms = false;
                              });
                              scrollToBottom();
                            },
                            title: 'Synonyms',
                          )
                        : Container(),
                    hasAntonyms
                        ?  SuggestedItem(
                      onPressed: () {
                        setState(() {
                          _messages.add(BrickWallButtons(
                            borderColor: Colors.orange,
                            textColor: Colors.orange,
                            stringList: _listAntonyms,
                            itemOnPressed: (clickedWord) {
                              clickedWord =
                                  WordHandler.removeSpecialCharacters(
                                      clickedWord);
                              _handleSubmitted(clickedWord);
                            },
                          ));
                          hasAntonyms = false;
                        });
                        scrollToBottom();
                      },
                            title: 'Antonyms',
                          )
                        : Container(),
                    hasImages
                        ? const SuggestedItem(
                            title: 'Images',
                          )
                        : Container(),
                  ],
                )),
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
                      focusNode: Global.textFieldFocusNode,
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

class SuggestedItem extends StatefulWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  const SuggestedItem(
      {super.key, required this.title, this.onPressed, this.backgroundColor});

  @override
  State<SuggestedItem> createState() => _SuggestedItemState();
}

class _SuggestedItemState extends State<SuggestedItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.grey[800],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextButton(
            onPressed: widget.onPressed ?? () {},
            child: Text(
              widget.title,
              style: TextStyle(color: Colors.white),
            )),
      ),
    );
  }
}
