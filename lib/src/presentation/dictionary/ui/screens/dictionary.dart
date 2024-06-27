import 'package:diccon_evo/src/presentation/dictionary/ui/components/translate_word_in_sentences_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../../../core/core.dart';

class DictionaryView extends StatelessWidget {
  const DictionaryView({super.key});

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
                      itemCount: state.params.chatList.length,
                      addAutomaticKeepAlives: true,
                      controller: chatListBloc.chatListController,
                      itemBuilder: (BuildContext context, int index) {
                        return state.params.chatList[index];
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
              if (state.params.showRefreshAnswer)
                IconButton.filledTonal(onPressed: (){
                  chatListBloc.add(RefreshAnswerEvent());
                }, icon:  const Icon(Icons.refresh)),
              if (state.params.showRefreshSpecialized)
                IconButton.filledTonal(onPressed: (){
                  chatListBloc.add(RefreshSpecializedAnswerEvent());
                }, icon:  const Icon(Icons.refresh, color: Colors.orange,)),
              if (state.params.showSuggestionWords)
                Row(
                  children: state.params.suggestionWords.map((String word) {
                    return SuggestedItem(
                      title: word,
                      textColor: context.theme.colorScheme.onPrimary,
                      backgroundColor: context.theme.colorScheme.primary,
                      onPressed: (String clickedWord) {
                        chatListBloc.add(
                            GetBasicTranslationEvent(providedWord: clickedWord));
                      },
                    );
                  }).toList(),
                ),
              if (state.params.showSpecialized)
                SuggestedItem(
                  textColor: context.theme.colorScheme.surface,
                  backgroundColor: context.theme.colorScheme.surfaceTint,
                  onPressed: (String a) {
                    chatListBloc.add(GetSpecializedTranslationEvent(providedWord: state.params.currentWord));
                  },
                  title: Properties.instance.settings.dictionarySpecializedVietnamese.i18n,
                ),
              if (state.params.showSynonyms)
                SuggestedItem(
                  onPressed: (String a) {
                    chatListBloc.add(GetSynonymsEvent(
                      providedWord: state.params.currentWord,
                      itemOnPressed: (clickedWord) {
                        chatListBloc.add(
                            GetBasicTranslationEvent(providedWord: clickedWord));
                      },
                    ));
                  },
                  title: 'Synonyms'.i18n,
                ),
              if (state.params.showAntonyms)
                SuggestedItem(
                  onPressed: (String a) {
                    chatListBloc.add(GetAntonymsEvent(
                      providedWord: state.params.currentWord,
                      itemOnPressed: (clickedWord) {
                        chatListBloc.add(
                            GetBasicTranslationEvent(providedWord: clickedWord));
                      },
                    ));
                  },
                  title: 'Antonyms'.i18n,
                ),
              if (state.params.showImage)
                SuggestedItem(
                  title: 'Images'.i18n,
                  onPressed: (String a) {
                    chatListBloc.add(ShowImageEvent());
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
                chatListBloc
                    .add(GetBasicTranslationEvent(providedWord: providedWord));
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
