import 'package:flutter/material.dart';
import '../../commons/notify.dart';
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
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void _handleSubmitted(String searchWord, BuildContext context) async {
    var conversationBloc = context.read<ConversationBloc>();
    conversationBloc.textController.clear();

    /// Add left bubble as user message
    conversationBloc.add(AskAQuestion(providedWord: searchWord));

    // Dismiss keyboard
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final conversationBloc = context.read<ConversationBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            BlocConsumer<ConversationBloc, ConversationState>(
              buildWhen: (previous, current) =>
                  current is! ConversationActionState,
              listenWhen: (previous, current) =>
                  current is ConversationActionState,
              listener: (BuildContext context, ConversationState state) {},
              builder: (context, state) {
                {
                  switch (state.runtimeType) {
                    case ConversationInitial:
                      final data = state as ConversationInitial;
                      return ListView.builder(
                        itemCount: data.conversation.length,
                        controller:
                            conversationBloc.conversationScrollController,
                        itemBuilder: (BuildContext context, int index) {
                          return state.conversation[index];
                        },
                      );
                    case ConversationUpdated:
                      final data = state as ConversationUpdated;
                      return ListView.builder(
                        padding: const EdgeInsets.only(top: 80, bottom: 120),
                        itemCount: data.conversation.length,
                        controller:
                            conversationBloc.conversationScrollController,
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
            Column(
              children: [
                /// Conversation header
                Expanded(
                  child: Header(
                    title: "Conversation".i18n,
                  ),
                ),

                /// Text field
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
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.0),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.1),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.5),
                                Theme.of(context)
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.9),
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context).scaffoldBackgroundColor,
                                Theme.of(context).scaffoldBackgroundColor,
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
                              //margin:  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: <Widget>[
                                  IconButton(
                                    onPressed: () {
                                      Notify.showAlertDialog(
                                          context: context,
                                          title: "Close this session?",
                                          content:
                                              "Clear all the bubbles in this translation session.",
                                          action: () {
                                            conversationBloc
                                                .add(ResetConversation());
                                          });
                                    },
                                    icon: Icon(
                                      Icons.add_circle_outline,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  Expanded(
                                    child: TextField(
                                      controller:
                                          conversationBloc.textController,
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
