import 'package:diccon_evo/extensions/string.dart';
import 'package:diccon_evo/repositories/thesaurus_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../components/circle_button.dart';
import '../bloc/chat_list_bloc.dart';
import '../../../helpers/image_handler.dart';
import '../../../config/properties.dart';
import '../../../extensions/target_platform.dart';
import '../../components/suggested_item.dart';
import '../../../extensions/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatListController = ScrollController();
  final ImageHandler imageProvider = ImageHandler();
  List<String> suggestionWords = [];
  String imageUrl = '';
  bool hasImages = false;
  bool hasAntonyms = false;
  bool hasSynonyms = false;
  bool hasSuggestionWords = true;
  String currentSearchWord = '';

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetSuggestion() {
    setState(() {
      hasImages = false;
      hasAntonyms = false;
      hasSynonyms = false;
      hasSuggestionWords = false;
    });
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

  void _handleSubmitted(
      String searchWord, BuildContext context, ChatListState state) async {
    currentSearchWord = searchWord;
    var chatListBloc = context.read<ChatListBloc>();
    _textController.clear();
    resetSuggestion();

    /// Add left bubble as user message
    chatListBloc.add(AddUserMessage(providedWord: searchWord));
    try {
      /// Right bubble represent machine reply
      chatListBloc.add(AddLocalTranslation(
        providedWord: searchWord,
        onWordTap: (clickedWord) {
          _handleSubmitted(clickedWord, context, state);
        },
      ));

      /// Get and add list synonyms to message box
      var listSynonyms = ThesaurusRepository().getSynonyms(searchWord);
      var listAntonyms = ThesaurusRepository().getAntonyms(searchWord);
      if (listSynonyms.isNotEmpty) {
        hasSynonyms = true;
      }
      if (listAntonyms.isNotEmpty) {
        hasAntonyms = true;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception is thrown when searching in dictionary");
      }

      /// When a word can't be found. It'll show a message to notify that error.
      chatListBloc.add(AddSorryMessage());
    }

    if (defaultTargetPlatform.isMobile()) {
      // Remove focus out of TextField in DictionaryView
      Properties.textFieldFocusNode.unfocus();
    } else {
      // On desktop we request focus, not on mobile
      Properties.textFieldFocusNode.requestFocus();
    }

    /// Unnecessary task that do not required to be display on screen will be run after all
    /// Delay the scroll animation until after the list has been updated
    scrollToBottom();

    /// Find image to show
    imageUrl = await imageProvider.getImageFromPixabay(searchWord);
    if (imageUrl.isNotEmpty) {
      setState(() {
        hasImages = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var chatListBloc = context.read<ChatListBloc>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ChatListBloc, ChatListState>(
          builder: (context, state) {
            {
              if (state is ImageAdded) {
                hasImages = false;
                scrollToBottom();
              }
              if (state is SynonymsAdded) {
                hasSynonyms = false;
                scrollToBottom();
              }
              if (state is AntonymsAdded) {
                hasAntonyms = false;
                scrollToBottom();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header
                  Container(
                    padding: const EdgeInsets.only(top: 16, left: 16, bottom : 8, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleButton(
                            iconData: Icons.arrow_back,
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        const SizedBox(width: 16,),
                        Text("Dictionary".i18n, style: const TextStyle(fontSize: 28))
                      ],
                    ),
                  ),
                  /// List of all bubble messages on a conversation
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.chatList.length,
                      controller: _chatListController,
                      itemBuilder: (BuildContext context, int index) {
                        return state.chatList[index];
                      },
                    ),
                  ),

                  /// Suggestion bar with different suggestive button
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
                          hasSuggestionWords
                              ? Row(
                                  children: suggestionWords.map((String word) {
                                    return SuggestedItem(
                                      title: word,
                                      backgroundColor: Colors.blue,
                                      onPressed: (String clickedWord) {
                                        _handleSubmitted(
                                            clickedWord, context, state);
                                      },
                                    );
                                  }).toList(),
                                )
                              : const SizedBox.shrink(),
                          hasSynonyms
                              ? SuggestedItem(
                                  onPressed: (String a) {
                                    chatListBloc.add(AddSynonyms(
                                      providedWord: currentSearchWord,
                                      itemOnPressed: (clickedWord) {
                                        _handleSubmitted(
                                            clickedWord, context, state);
                                      },
                                    ));
                                  },
                                  title: 'Synonyms'.i18n,
                                )
                              : const SizedBox.shrink(),
                          hasAntonyms
                              ? SuggestedItem(
                                  onPressed: (String a) {
                                    chatListBloc.add(AddAntonyms(
                                      providedWord: currentSearchWord,
                                      itemOnPressed: (clickedWord) {
                                        _handleSubmitted(
                                            clickedWord, context, state);
                                      },
                                    ));
                                  },
                                  title: 'Antonyms'.i18n,
                                )
                              : const SizedBox.shrink(),
                          hasImages
                              ? SuggestedItem(
                                  title: 'Images'.i18n,
                                  onPressed: (String a) {
                                    chatListBloc
                                        .add(AddImage(imageUrl: imageUrl));
                                  },
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),

                  /// TextField for user to enter their words
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    margin: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            focusNode: Properties.textFieldFocusNode,
                            onSubmitted: (providedWord) {
                              _handleSubmitted(providedWord, context, state);
                            },
                            onChanged: (word) {
                              Set<String> listStartWith = {};
                              Set<String> listContains = {};
                              const int suggestionLimit = 5;
                              if (word.length > 1) {
                                for (final element
                                    in Properties.suggestionListWord) {
                                  if (element.startsWith(word)) {
                                    listStartWith.add(element);
                                    if (listStartWith.length >=
                                        suggestionLimit) {
                                      break;
                                    }
                                  } else if (element.contains(word) &&
                                      listContains.length < suggestionLimit) {
                                    listContains.add(element);
                                  }
                                }

                                suggestionWords = [
                                  ...listStartWith,
                                  ...listContains
                                ].toList();
                                suggestionWords.reversed;
                              }
                              setState(() {
                                hasSuggestionWords = true;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Send a message".i18n,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                              ),
                            ),
                            controller: _textController,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}