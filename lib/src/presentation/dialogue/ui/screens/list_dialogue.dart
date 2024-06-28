import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:diccon_evo/src/presentation/dialogue/ui/screens/add_new_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/bloc/list_dialogue_bloc.dart';
import '../../data/bloc/list_dialogue_event.dart';
import '../../data/bloc/list_dialogue_state.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';
import 'dialogue.dart';
import '../../../../domain/domain.dart';

class ListDialogueView extends StatefulWidget {
  const ListDialogueView({super.key});

  @override
  State<ListDialogueView> createState() => _ListDialogueViewState();
}

class _ListDialogueViewState extends State<ListDialogueView> {
  @override
  void initState() {
    super.initState();
    context.read<ListDialogueBloc>().add(LoadConversations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogue'.i18n),
        actions: [
          if (Properties.isEditor)
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddNewDialogue()));
              },
              icon: const Icon(Icons.add),
            ),
          IconButton(
            onPressed: () => showSearchPage(context),
            icon: const Icon(Icons.search),
          ),
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.theme.dividerColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Seen".i18n),
                onTap: () {
                  // Implement Seen functionality
                },
              ),
              PopupMenuItem(
                child: Text("Newest".i18n),
                onTap: () {
                  // Implement Newest functionality
                },
              ),
              const PopupMenuItem(
                enabled: false,
                height: 0,
                child: WaveDivider(
                  thickness: .3,
                ),
              ),
              PopupMenuItem(
                child: Text("All".i18n),
                onTap: () {
                  // Implement All functionality
                },
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<ListDialogueBloc, ListDialogueState>(
        builder: (context, state) {
          if (state is ListDialogueLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ListDialogueError) {
            return Center(child: Text(state.error));
          } else if (state is ListDialogueLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
                    child: Text(
                      'dialogue_corner_welcoming'.i18n,
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                          color: context.theme.colorScheme.onSurface),
                    ),
                  ),
                  const WaveDivider(
                    thickness: .3,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.conversations.length,
                    itemBuilder: (context, index) {
                      final conversation = state.conversations[index];
                      return ListTile(
                        title: Text(conversation.title),
                        subtitle: Text(
                          conversation.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.theme.textTheme.bodyMedium?.copyWith(
                              color: context.theme.textTheme.bodyMedium?.color
                                  ?.withOpacity(.5)),
                        ),
                        trailing: state.haveReadDialogueDescriptionList.contains(conversation.description)
                            ? Icon(Icons.check, color: context.theme.colorScheme.primary,)
                            : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DialogueView(
                                conversation: conversation,
                                listConversation: state.conversations,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> showSearchPage(BuildContext context) async {
    List<Conversation> conversations =
        context.read<ListDialogueBloc>().state is ListDialogueLoaded
            ? (context.read<ListDialogueBloc>().state as ListDialogueLoaded)
                .conversations
            : [];

    showSearch(
      context: context,
      delegate: SearchPage<Conversation>(
        items: conversations,
        searchLabel: 'Find a conversation'.i18n,
        searchStyle: context.theme.textTheme.titleMedium,
        failure: Center(
          child: Text('No matching conversation found'.i18n),
        ),
        filter: (conversation) => [
          conversation.title,
          conversation.hashtags.toString(),
          conversation.description
        ],
        builder: (conversation) => ListTile(
          title: Text(conversation.title),
          subtitle: Opacity(
            opacity: .5,
            child: Text(
              conversation.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DialogueView(
                  conversation: conversation,
                  listConversation: conversations,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
