import 'dart:io';

import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/settings/ui/screens/purchase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    final chatbotBloc = context.read<ChatbotBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chatbot",
        ),
      ),
      body: Stack(
        children: [
          BlocConsumer<ChatbotBloc, ChatbotState>(
            buildWhen: (previous, current) =>
                current is! ChatbotActionState,
            listenWhen: (previous, current) =>
                current is ChatbotActionState,
            listener: (BuildContext context, ChatbotState state) {
              if (state is NotHaveEnoughToken) {
                if (Platform.isWindows) {
                  context.showAlertDialogWithoutAction(
                    title: 'You have no tokens left',
                    content:
                        'Please consider purchase more to continue sending messages.',
                  );
                }
                if (Platform.isAndroid) {
                  context.showAlertDialog(
                    actionButtonTitle: 'Upgrade'.i18n,
                    title: 'You have no tokens left',
                    content:
                        'Please consider purchase more to continue sending messages.',
                    action: () {
                      chatbotBloc.add(GoToUpgradeScreenEvent());
                    },
                  );
                }
              }
              if (state is RequiredLogIn) {
                context.showAlertDialogWithoutAction(
                    title: 'Login is required'.i18n,
                    content: 'You need to login to use this function.'.i18n);
              }
              if (state is GoToUpgradeScreen) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InAppPurchaseView()));
              }
            },
            builder: (context, state) {
              {
                switch (state) {
                  case ChatbotInitial _:
                    return ListView.builder(
                      itemCount: state.conversation.length,
                      controller: chatbotBloc.conversationScrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return state.conversation[index];
                      },
                    );
                  case ChatbotUpdated _:
                    return Stack(
                      children: [
                        ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.only(
                              top: 80, bottom: 140, left: 16, right: 16),
                          itemCount: state.conversation.length,
                          controller:
                              chatbotBloc.conversationScrollController,
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
                                    chatbotBloc.add(StopResponse());
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
                                            "Clear all the bubbles in this translation session."
                                                .i18n,
                                        action: () {
                                          chatbotBloc
                                              .add(ResetConversation());
                                        });
                                  },
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    color: context.theme.colorScheme.onSurface,
                                  ),
                                ),
                                Expanded(
                                  child: BlocBuilder<ChatbotBloc,
                                          ChatbotState>(
                                      builder: (context, state) {
                                    if (state is ChatbotUpdated) {
                                      return SearchBox(
                                        searchTextController:
                                            chatbotBloc.textController,
                                        enableCamera: false,
                                        hintText:
                                            "Send a message for practice".i18n,
                                        enabled: !state.isResponding,
                                        onSubmitted: (providedWord) {
                                          //_handleSubmitted(providedWord, context);
                                          chatbotBloc.add(AskAQuestion(
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
                                          chatbotBloc.textController,
                                      enableCamera: false,
                                      hintText:
                                          "Send a message for practice".i18n,
                                      onSubmitted: (providedWord) {
                                        //_handleSubmitted(providedWord, context);
                                        chatbotBloc.add(AskAQuestion(
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
