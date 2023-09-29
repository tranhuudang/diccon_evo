import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../commons/header.dart';
import '../bloc/conversation_bloc.dart';
import '../../../config/properties.dart';
import '../../../extensions/target_platform.dart';
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
  final ScrollController _conversationScrollController = ScrollController();

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void scrollToBottom() {
    /// Delay the scroll animation until after the list has been updated
    Future.delayed(const Duration(milliseconds: 300), () {
      _conversationScrollController.animateTo(
        _conversationScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _handleSubmitted(String searchWord, BuildContext context) async {
    var conversationBloc = context.read<ConversationBloc>();
    _textController.clear();

    /// Add left bubble as user message
    conversationBloc.add(AddUserMessage(providedWord: searchWord));

    /// Right bubble represent machine reply
    conversationBloc.add(AddBotReply(
      providedWord: searchWord,
      onWordTap: (clickedWord) {
        _handleSubmitted(clickedWord, context);
      },
    ));

    if (defaultTargetPlatform.isMobile()) {
      // Remove focus out of TextField in ConversationView
      Properties.textFieldFocusNode.unfocus();
    } else {
      // On desktop we request focus, not on mobile
      Properties.textFieldFocusNode.requestFocus();
    }

    /// Unnecessary task that do not required to be display on screen will be run after all
    /// Delay the scroll animation until after the list has been updated
    scrollToBottom();
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
    _conversationScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var conversationBloc = context.read<ConversationBloc>();
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
                              controller: _conversationScrollController,
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
                              controller: _conversationScrollController,
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
                                      //focusNode: Properties.textFieldFocusNode,
                                      onSubmitted: (providedWord) {
                                        _handleSubmitted(providedWord, context);
                                      },
                                      decoration: InputDecoration(
                                        hintText:
                                            "Send a message to practice".i18n,
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
