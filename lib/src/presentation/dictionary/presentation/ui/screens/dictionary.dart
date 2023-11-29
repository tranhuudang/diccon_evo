import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../../../../core/core.dart';
import '../../../../../data/data.dart';
import '../../../../../domain/domain.dart';

class DictionaryView extends StatefulWidget {
  final String? word;
  final BuildContext? buildContext;
  const DictionaryView({super.key, this.word = "", this.buildContext});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  final ImageHandler _imageProvider = ImageHandler();
  final suggestionWordListDb = SuggestionDatabase.instance;

  final EnglishToVietnameseDictionaryRepository dictionaryRepository =
      EnglishToVietnameseDictionaryRepositoryImpl();
  List<String> _suggestionWords = [];
  String _imageUrl = '';
  bool _hasImages = false;
  bool _hasAntonyms = false;
  bool _hasSynonyms = false;
  bool _hasSuggestionWords = true;
  String _currentSearchWord = '';

  void resetSuggestion() {
    setState(() {
      _hasImages = false;
      _hasAntonyms = false;
      _hasSynonyms = false;
      _hasSuggestionWords = false;
    });
  }

  void _handleSubmitted(String searchWord, BuildContext context) async {
    _currentSearchWord = searchWord;
    var chatListBloc = context.read<ChatListBloc>();
    chatListBloc.textController.clear();
    resetSuggestion();

    /// Add left bubble as user message
    chatListBloc.add(AddUserMessage(providedWord: searchWord));
    try {
      /// Right bubble represent machine reply
      chatListBloc.add(
        AddTranslation(
          providedWord: searchWord,
        ),
      );

      /// Get and add list synonyms to message box
      var listSynonyms = await dictionaryRepository.getSynonyms(searchWord);
      var listAntonyms = await dictionaryRepository.getAntonyms(searchWord);

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
    FocusNode textFieldFocusNode = FocusNode();
    if (defaultTargetPlatform.isMobile()) {
      // Remove focus out of TextField in DictionaryView
      textFieldFocusNode.unfocus();
    } else {
      // On desktop we request focus, not on mobile
      textFieldFocusNode.requestFocus();
    }

    /// Find image to show
    _imageUrl = await _imageProvider.getImageFromPixabay(searchWord);
    if (_imageUrl.isNotEmpty) {
      setState(() {
        _hasImages = true;
      });
    } else {
      setState(() {
        _hasImages = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.word != "") {
      _handleSubmitted(widget.word!, widget.buildContext!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    final settingBloc = context.read<SettingBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            BlocConsumer<ChatListBloc, ChatListState>(
              buildWhen: (previous, current) => current is! ChatListActionState,
              listenWhen: (previous, current) => current is ChatListActionState,
              listener: (BuildContext context, ChatListState state) {
                if (state is ImageAdded) {
                  setState(() {
                    _hasImages = false;
                  });
                }
                if (state is SynonymsAdded) {
                  setState(() {
                    _hasSynonyms = false;
                  });
                }
                if (state is AntonymsAdded) {
                  setState(() {
                    _hasAntonyms = false;
                  });
                }
              },
              builder: (context, state) {
                {
                  switch (state.runtimeType) {
                    case ChatListUpdated:
                      final data = state as ChatListUpdated;
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 80, bottom: 130),
                        itemCount: data.chatList.length,
                        addAutomaticKeepAlives: true,
                        controller: chatListBloc.chatListController,
                        itemBuilder: (BuildContext context, int index) {
                          return state.chatList[index];
                        },
                      );
                    default:
                      return const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DictionaryWelcome(),
                        ],
                      );
                  }
                }
              },
            ),
            Column(
              children: [
                /// Dictionary header
                Expanded(
                  child: ScreenTypeLayout.builder(mobile: (context) {
                    return Header(
                      enableBackButton: true,
                      title: "Dictionary".i18n,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.history),
                          onPressed: () {
                            context.pushNamed('word-history');
                          },
                        ),
                        const DictionaryMenu(),
                      ],
                    );
                  }, tablet: (context) {
                    return Header(
                      enableBackButton: false,
                      title: "Dictionary".i18n,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.history),
                          onPressed: () {
                            context.pushNamed('word-history');
                          },
                        ),
                        const DictionaryMenu(),
                      ],
                    );
                  }),
                ),

                SizedBox(
                  height: 138,
                  child: Stack(
                    children: [
                      buildBackgroundGradient(context),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// Suggested items list onTyping or onSubmit of TextField
                          buildSuggestedList(context, chatListBloc),

                          /// TextField for user to enter their words
                          buildTextField(context, chatListBloc, settingBloc),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container buildBackgroundGradient(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            context.theme.scaffoldBackgroundColor.withOpacity(0.0),
            context.theme.scaffoldBackgroundColor.withOpacity(0.1),
            context.theme.scaffoldBackgroundColor.withOpacity(0.5),
            context.theme.scaffoldBackgroundColor.withOpacity(0.9),
            context.theme.scaffoldBackgroundColor,
            context.theme.scaffoldBackgroundColor,
            context.theme.scaffoldBackgroundColor,
            context.theme.scaffoldBackgroundColor,
          ])),
    );
  }

  Align buildSuggestedList(BuildContext context, ChatListBloc chatListBloc) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              width: 16,
            ),
            if (_hasSuggestionWords)
              Row(
                children: _suggestionWords.map((String word) {
                  return SuggestedItem(
                    title: word,
                    textColor: context.theme.colorScheme.onPrimary,
                    backgroundColor: context.theme.colorScheme.primary,
                    onPressed: (String clickedWord) {
                      _handleSubmitted(clickedWord, context);
                    },
                  );
                }).toList(),
              ),
            if (_hasSynonyms)
              SuggestedItem(
                onPressed: (String a) {
                  chatListBloc.add(AddSynonyms(
                    providedWord: _currentSearchWord,
                    itemOnPressed: (clickedWord) {
                      _handleSubmitted(clickedWord, context);
                    },
                  ));
                },
                title: 'Synonyms'.i18n,
              ),
            if (_hasAntonyms)
              SuggestedItem(
                onPressed: (String a) {
                  chatListBloc.add(AddAntonyms(
                    providedWord: _currentSearchWord,
                    itemOnPressed: (clickedWord) {
                      _handleSubmitted(clickedWord, context);
                    },
                  ));
                },
                title: 'Antonyms'.i18n,
              ),
            if (_hasImages)
              SuggestedItem(
                title: 'Images'.i18n,
                onPressed: (String a) {
                  chatListBloc.add(AddImage(imageUrl: _imageUrl));
                },
              ),
          ],
        ),
      ),
    );
  }

  Container buildTextField(BuildContext context, ChatListBloc chatListBloc,
      SettingBloc settingBloc) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 16),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          const DictionaryBottomMenu(),
          Expanded(
            child: SearchBox(
              searchTextController: chatListBloc.textController,
              hintText: "Send a message".i18n,
              onSubmitted: (providedWord) {
                _handleSubmitted(providedWord, context);
              },
              onChanged: (currentValue) async {
                Set<String> listStartWith = {};
                Set<String> listContains = {};
                final suggestionWordList = await suggestionWordListDb.database;
                var refinedWord = currentValue.toLowerCase();
                const int suggestionLimit = 5;
                if (refinedWord.length > 1) {
                  for (final element in suggestionWordList) {
                    if (element.startsWith(refinedWord)) {
                      listStartWith.add(element);
                      if (listStartWith.length >= suggestionLimit) {
                        break;
                      }
                    } else if (element.contains(refinedWord) &&
                        listContains.length < suggestionLimit) {
                      listContains.add(element);
                    }
                  }
                  if (settingBloc.state.params.translationLanguageTarget !=
                      TranslationLanguageTarget.vietnameseToEnglish) {
                    _suggestionWords =
                        [...listStartWith, ...listContains].toList();
                    _suggestionWords.reversed;
                  }
                  setState(() {
                    _hasSuggestionWords = true;
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
