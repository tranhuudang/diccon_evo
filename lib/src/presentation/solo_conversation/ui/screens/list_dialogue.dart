import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:search_page/search_page.dart';
import '../../../../domain/domain.dart';
import 'dialogue.dart';

class ListDialogueView extends StatefulWidget {
  const ListDialogueView({super.key});

  @override
  State<ListDialogueView> createState() => _ListDialogueViewState();
}

class _ListDialogueViewState extends State<ListDialogueView> {
  List<Conversation> conversations = [];

  @override
  void initState() {
    super.initState();
    _loadConversations();
  }

  Future<void> _loadConversations() async {
    try {
      String data = await rootBundle
          .loadString('assets/solo_conversation/solo_conversation.json');
      List<dynamic> jsonList = jsonDecode(data);
      setState(() {
        conversations =
            jsonList.map((json) => Conversation.fromJson(json)).toList();
      });
    } catch (e) {
      print('Error loading conversation data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialogue'.i18n),
        actions: [
          IconButton(
              onPressed: () => showSearchPage(context),
              icon: const Icon(Icons.search)),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
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
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DialogueView(
                            conversation: conversation,
                            listConversation: conversations,
                          )));
            },
          );
        },
      ),
    );
  }

  Future<void> showSearchPage(BuildContext context) async {
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
          titleTextStyle: context.theme.textTheme.titleMedium,
          subtitle: Opacity(
              opacity: .5,
              child: Text(
                conversation.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              )),
          subtitleTextStyle: context.theme.textTheme.bodyMedium,
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DialogueView(
                          conversation: conversation,
                          listConversation: conversations,
                        )));
          },
        ),
      ),
    );
  }
}
