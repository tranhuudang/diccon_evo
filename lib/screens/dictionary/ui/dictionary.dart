import 'dart:async';
import 'dart:ui';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/pill_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import '../../../data/handlers/image_handler.dart';
import '../../../data/repositories/thesaurus_repository.dart';
import '../../commons/header.dart';
import '../../commons/suggested_item.dart';
import '../bloc/chat_list_bloc.dart';
import '../../../config/properties.dart';
import '../../../extensions/target_platform.dart';
import '../../../extensions/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'word_history.dart';
import 'package:shimmer/shimmer.dart';

class DictionaryView extends StatefulWidget {
  const DictionaryView({super.key});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _chatListController = ScrollController();
  final ImageHandler _imageProvider = ImageHandler();
  List<String> _suggestionWords = [];
  String _imageUrl = '';
  bool _hasImages = false;
  bool _hasAntonyms = false;
  bool _hasSynonyms = false;
  bool _hasSuggestionWords = true;
  String _currentSearchWord = '';

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void resetSuggestion() {
    setState(() {
      _hasImages = false;
      _hasAntonyms = false;
      _hasSynonyms = false;
      _hasSuggestionWords = false;
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

  void _handleSubmitted(String searchWord, BuildContext context) async {
    _currentSearchWord = searchWord;
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
          _handleSubmitted(clickedWord, context);
        },
      ));

      /// Get and add list synonyms to message box
      var listSynonyms = ThesaurusRepository().getSynonyms(searchWord);
      var listAntonyms = ThesaurusRepository().getAntonyms(searchWord);
      if (listSynonyms.isNotEmpty) {
        _hasSynonyms = true;
      }
      if (listAntonyms.isNotEmpty) {
        _hasAntonyms = true;
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
    _imageUrl = await _imageProvider.getImageFromPixabay(searchWord);
    if (_imageUrl.isNotEmpty) {
      setState(() {
        _hasImages = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var chatListBloc = context.read<ChatListBloc>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// List of all bubble messages on a conversation
                Expanded(
                  child: BlocConsumer<ChatListBloc, ChatListState>(
                    buildWhen: (previous, current) =>
                        current is! ChatListActionState,
                    listenWhen: (previous, current) =>
                        current is ChatListActionState,
                    listener: (BuildContext context, ChatListState state) {
                      if (state is ImageAdded) {
                        scrollToBottom();
                        setState(() {
                          _hasImages = false;

                        });
                      }
                      if (state is SynonymsAdded) {

                        scrollToBottom();
                        setState(() {
                          _hasSynonyms = false;

                        });
                      }
                      if (state is AntonymsAdded) {

                        scrollToBottom();
                        setState(() {
                          _hasAntonyms = false;

                        });
                      }
                    },
                    builder: (context, state) {
                      {

                        switch (state.runtimeType) {
                          case ChatListInitial:
                            final data = state as ChatListInitial;
                            return ListView.builder(
                              itemCount: data.chatList.length,
                              controller: _chatListController,
                              itemBuilder: (BuildContext context, int index) {
                                return state.chatList[index];
                              },
                            );
                          case ChatListUpdated:
                            final data = state as ChatListUpdated;
                            return ListView.builder(
                              padding:
                                  const EdgeInsets.only(top: 80, bottom: 120),
                              itemCount: data.chatList.length,
                              controller: _chatListController,
                              itemBuilder: (BuildContext context, int index) {
                                return state.chatList[index];
                              },
                            );
                          default:
                            return Container();
                        }
                      }
                    },
                  ),
                ),
                //const SizedBox(height: 116),
              ],
            ),
            Column(
              children: [
                Header(
                  title: "Dictionary".i18n,
                  actions: [
                    PillButton(
                        icon: Icons.auto_awesome,
                        onTap: () {},
                        title: "Default Bot")
                  ],
                ),
                const Spacer(),
                ClipRect(
                  child: Container(
                    height: 130,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor!
                                    .withOpacity(0.0),
                                Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor!
                                    .withOpacity(0.1),
                                Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor!
                                    .withOpacity(0.5),
                                Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor!
                                    .withOpacity(0.9),
                                Theme.of(context).appBarTheme.backgroundColor!,
                                Theme.of(context).appBarTheme.backgroundColor!,
                                Theme.of(context).appBarTheme.backgroundColor!,
                                Theme.of(context).appBarTheme.backgroundColor!,
                              ])),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                    _hasSuggestionWords
                                        ? Row(
                                            children: _suggestionWords
                                                .map((String word) {
                                              return SuggestedItem(
                                                title: word,
                                                backgroundColor: Colors.blue,
                                                onPressed:
                                                    (String clickedWord) {
                                                  _handleSubmitted(
                                                      clickedWord, context);

                                                },
                                              );
                                            }).toList(),
                                          )
                                        : const SizedBox.shrink(),
                                    _hasSynonyms
                                        ? SuggestedItem(
                                            onPressed: (String a) {
                                              chatListBloc.add(AddSynonyms(
                                                providedWord:
                                                    _currentSearchWord,
                                                itemOnPressed: (clickedWord) {
                                                  _handleSubmitted(
                                                      clickedWord, context);
                                                },
                                              ));
                                            },
                                            title: 'Synonyms'.i18n,
                                          )
                                        : const SizedBox.shrink(),
                                    _hasAntonyms
                                        ? SuggestedItem(
                                            onPressed: (String a) {
                                              chatListBloc.add(AddAntonyms(
                                                providedWord:
                                                    _currentSearchWord,
                                                itemOnPressed: (clickedWord) {
                                                  _handleSubmitted(
                                                      clickedWord, context);
                                                },
                                              ));
                                            },
                                            title: 'Antonyms'.i18n,
                                          )
                                        : const SizedBox.shrink(),
                                    _hasImages
                                        ? SuggestedItem(
                                            title: 'Images'.i18n,
                                            onPressed: (String a) {
                                              chatListBloc.add(AddImage(
                                                  imageUrl: _imageUrl));
                                            },
                                          )
                                        : const SizedBox.shrink(),
                                  ],
                                ),
                              ),
                            ),

                            /// TextField for user to enter their words
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 2, bottom: 16),
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: TextField(
                                      focusNode: Properties.textFieldFocusNode,
                                      onSubmitted: (providedWord) {
                                        _handleSubmitted(providedWord, context);
                                      },
                                      onChanged: (String word) {
                                        Set<String> listStartWith = {};
                                        Set<String> listContains = {};
                                        var refinedWord = word.toLowerCase();
                                        const int suggestionLimit = 5;
                                        if (refinedWord.length > 1) {
                                          for (final element in Properties
                                              .suggestionListWord) {
                                            if (element
                                                .startsWith(refinedWord)) {
                                              listStartWith.add(element);
                                              if (listStartWith.length >=
                                                  suggestionLimit) {
                                                break;
                                              }
                                            } else if (element
                                                    .contains(refinedWord) &&
                                                listContains.length <
                                                    suggestionLimit) {
                                              listContains.add(element);
                                            }
                                          }

                                          _suggestionWords = [
                                            ...listStartWith,
                                            ...listContains
                                          ].toList();
                                          _suggestionWords.reversed;
                                        }
                                        setState(() {
                                          _hasSuggestionWords = true;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Send a message".i18n,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
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
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
