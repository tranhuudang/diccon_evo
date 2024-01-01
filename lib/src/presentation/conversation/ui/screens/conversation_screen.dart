import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class ConversationView extends StatelessWidget {
  const ConversationView({super.key});

  @override
  Widget build(BuildContext context) {
    final conversationBloc = context.read<ConversationBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Conversation".i18n,),),
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
                switch (state) {
                  case ConversationInitial _:
                    return ListView.builder(
                      itemCount: state.conversation.length,
                      controller:
                          conversationBloc.conversationScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return state.conversation[index];
                      },
                    );
                  case ConversationUpdated _:
                    return Stack(
                      children: [
                        ListView.builder(
                          padding:
                              const EdgeInsets.only(top: 80, bottom: 120, left: 16, right: 16),
                          itemCount: state.conversation.length,
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
              const Spacer(),
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
                              context.theme.scaffoldBackgroundColor
                                  .withOpacity(0.0),
                              context.theme.scaffoldBackgroundColor
                                  .withOpacity(0.3),
                              context.theme.scaffoldBackgroundColor
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
                                        title: "Close this session?".i18n,
                                        content:
                                            "Clear all the bubbles in this translation session.".i18n,
                                        action: () {
                                          conversationBloc
                                              .add(ResetConversation());
                                        });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color:
                                        context.theme.colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<ConversationBloc,
                                          ConversationState>(
                                      builder: (context, state) {
                                    if (state is ConversationUpdated) {
                                      return SearchBox(
                                        searchTextController:
                                            conversationBloc.textController,
                                        enableCamera: false,
                                        hintText:
                                            "Send a message for practice"
                                                .i18n,
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
                                      searchTextController:
                                          conversationBloc.textController,
                                      enableCamera: false,
                                      hintText:
                                          "Send a message for practice".i18n,
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
    );
  }
}
