import 'package:flutter/material.dart';
import '../../commons/header.dart';
import '../bloc/conversation_bloc.dart';
import '../../../extensions/i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationView extends StatefulWidget {
  const ConversationView({super.key});

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _textController = TextEditingController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;



  void _handleSubmitted(String searchWord, BuildContext context) async {
    var conversationBloc = context.read<ConversationBloc>();
    _textController.clear();

    /// Add left bubble as user message
    conversationBloc.add(AskAQuestion(providedWord: searchWord));

    // Dismiss keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final conversationBloc = context.read<ConversationBloc>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// List of all bubble messages on a conversation
                Expanded(
                  child: BlocConsumer<ConversationBloc, ConversationState>(
                    buildWhen: (previous, current) =>
                        current is! ConversationActionState,
                    listenWhen: (previous, current) =>
                        current is ConversationActionState,
                    listener:
                        (BuildContext context, ConversationState state) {},
                    builder: (context, state) {
                      {
                        switch (state.runtimeType) {
                          case ConversationInitial:
                            final data = state as ConversationInitial;
                            return ListView.builder(
                              itemCount: data.conversation.length,
                              controller: conversationBloc.conversationScrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return state.conversation[index];
                              },
                            );
                          case ConversationUpdated:
                            final data = state as ConversationUpdated;
                            return ListView.builder(
                              padding:
                                  const EdgeInsets.only(top: 80, bottom: 120),
                              itemCount: data.conversation.length,
                              controller: conversationBloc.conversationScrollController,
                              itemBuilder: (BuildContext context, int index) {
                                return state.conversation[index];
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
                /// Conversation header
                Expanded(
                  child: Header(
                    title: "Conversation".i18n,
                  ),
                ),

                /// Suggestion bar with different suggestive button
                ClipRect(
                  child: SizedBox(
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
                              ],
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                                      controller: _textController,
                                      onSubmitted: (providedWord) {
                                        _handleSubmitted(providedWord, context);
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            "Send a message for practice".i18n,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
                                        ),
                                      ),
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
