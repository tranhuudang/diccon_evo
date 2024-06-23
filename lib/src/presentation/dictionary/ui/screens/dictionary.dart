import 'package:diccon_evo/src/presentation/dictionary/ui/components/translate_word_in_sentences_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../../../core/core.dart';
import '../../../../data/data.dart';
import '../../../../domain/domain.dart';

class DictionaryView extends StatefulWidget {
  final String? word;
  final BuildContext? buildContext;
  const DictionaryView({super.key, this.word = "", this.buildContext});

  @override
  State<DictionaryView> createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> {
  final ImageHandler _imageProvider = ImageHandler();
  String _imageUrl = '';
  bool _hasImages = false;
  String _currentSearchWord = '';

  void _handleSubmitted(String searchWord, BuildContext context) async {
    _currentSearchWord = searchWord;
    var chatListBloc = context.read<ChatListBloc>();
    chatListBloc.textController.clear();

    /// Add left bubble as user message
    chatListBloc.add(AddUserMessageEvent(providedWord: searchWord));
    try {
      /// Right bubble represent machine reply
      chatListBloc.add(
        AddTranslationEvent(
          providedWord: searchWord,
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print("Exception is thrown when searching in dictionary");
      }

      /// When a word can't be found. It'll show a message to notify that error.
      chatListBloc.add(AddSorryMessageEvent());
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Dictionary".i18n,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              context.pushNamed('word-history');
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              context.pushNamed(RouterConstants.dictionaryPreferences);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<ChatListBloc, ChatListState>(
            buildWhen: (previous, current) => current is! ChatListActionState,
            listenWhen: (previous, current) => current is ChatListActionState,
            listener: (BuildContext context, ChatListState state) {
              // todo: action event go here
              // - alert new chat
            },
            builder: (context, state) {
              {
                switch (state) {
                  case ChatListUpdated _:
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      padding: const EdgeInsets.only(
                          top: 80, bottom: 120, left: 16, right: 16),
                      itemCount: state.params.chatList?.length ?? 0,
                      addAutomaticKeepAlives: true,
                      controller: chatListBloc.chatListController,
                      itemBuilder: (BuildContext context, int index) {
                        return state.params.chatList?[index];
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
              const Spacer(),
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

  BlocBuilder<ChatListBloc, ChatListState> buildSuggestedList(
      BuildContext context, ChatListBloc chatListBloc) {
    return BlocBuilder<ChatListBloc, ChatListState>(builder: (context, state) {
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
              if (state.params.showSuggestionWords)
                Row(
                  children: state.params.suggestionWords.map((String word) {
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
              if (state.params.showSynonyms)
                SuggestedItem(
                  onPressed: (String a) {
                    chatListBloc.add(GetSynonymsEvent(
                      providedWord: _currentSearchWord,
                      itemOnPressed: (clickedWord) {
                        _handleSubmitted(clickedWord, context);
                      },
                    ));
                  },
                  title: 'Synonyms'.i18n,
                ),
              if (state.params.showAntonyms)
                SuggestedItem(
                  onPressed: (String a) {
                    chatListBloc.add(GetAntonymsEvent(
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
                    chatListBloc.add(GetImageEvent(imageUrl: _imageUrl));
                  },
                ),
              SuggestedItem(
                title: 'Translate word from sentence'.i18n,
                onPressed: (String a) {
                  //chatListBloc.add(AddTranslateWordFromSentence());
                  showDialog(
                      context: context,
                      builder: (context) =>
                          const TranslateWordInSentenceDialog());
                },
              ),
            ],
          ),
        ),
      );
    });
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
              autofocus: true,
              searchTextController: chatListBloc.textController,
              hintText: "Send a message".i18n,
              onSubmitted: (providedWord) {
                _handleSubmitted(providedWord, context);
              },
              onChanged: (currentValue) async {
                chatListBloc.add(GetWordSuggestionEvent(word: currentValue));
              },
            ),
          ),
        ],
      ),
    );
  }
}
