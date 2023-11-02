import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/features/features.dart';


class ConversationView extends StatefulWidget {
  const ConversationView({super.key});

  @override
  State<ConversationView> createState() => _ConversationViewState();
}

class _ConversationViewState extends State<ConversationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final conversationBloc = context.read<ConversationBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
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
                      return Stack(
                        children: [
                          ListView.builder(
                            padding:
                                const EdgeInsets.only(top: 80, bottom: 120),
                            itemCount: data.conversation.length,
                            controller:
                                conversationBloc.conversationScrollController,
                            itemBuilder: (BuildContext context, int index) {
                              return state.conversation[index];
                            },
                          ),
                          if (state.isResponding)
                            SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  const Spacer(),
                                  PillButton(
                                    icon: Icons.stop_circle_outlined,
                                    onTap: () {
                                      conversationBloc.add(StopResponse());
                                    },
                                    title: 'Stop Responding',
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    default:
                      return Container();
                  }
                }
              },
            ),

            /// Conversation header
            Column(
              children: [
                Expanded(
                  child: Header(
                    title: "Conversation".i18n,
                  ),
                ),

                /// Text field
                ClipRect(
                  child: SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                context.theme
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.0),
                                context.theme
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.3),
                                context.theme
                                    .scaffoldBackgroundColor
                                    .withOpacity(0.9),
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
                                context.theme.scaffoldBackgroundColor,
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
                                      context.showAlertDialog(
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
                                      color: context.theme
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                                  Expanded(
                                    child: BlocBuilder<ConversationBloc,
                                            ConversationState>(
                                        builder: (context, state) {
                                      if (state is ConversationUpdated) {
                                        return SearchBox(
                                          searchTextController: conversationBloc.textController,
                                          enableCamera: false,
                                          hintText: "Send a message for practice".i18n,
                                          enabled: !state.isResponding,
                                          onSubmitted: (providedWord) {
                                            //_handleSubmitted(providedWord, context);
                                            conversationBloc.add(AskAQuestion(
                                                providedWord: providedWord));
                                            // Dismiss keyboard
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                          },
                                        );
                                      }

                                      return SearchBox(

                                        searchTextController: conversationBloc.textController,
                                        enableCamera: false,
                                        hintText: "Send a message for practice".i18n,
                                        onSubmitted: (providedWord) {
                                          //_handleSubmitted(providedWord, context);
                                          conversationBloc.add(AskAQuestion(
                                              providedWord: providedWord));
                                          // Dismiss keyboard
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                        },
                                      );
                                    }),
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
            ),
          ],
        ),
      ),
    );
  }
}
