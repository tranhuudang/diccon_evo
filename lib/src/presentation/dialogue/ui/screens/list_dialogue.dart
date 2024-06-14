import 'dart:io';

import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart'; // Import for rootBundle
import 'package:path_provider/path_provider.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../../domain/domain.dart';
import 'dialogue.dart';

class ListDialogueView extends StatefulWidget {
  const ListDialogueView({super.key});

  @override
  State<ListDialogueView> createState() => _ListDialogueViewState();
}

class _ListDialogueViewState extends State<ListDialogueView> {
  List<Conversation> conversations = [];
  String readStateFileContents = '';
  late File _readStateFile;

  @override
  void initState() {
    super.initState();
    _loadConversations();
    _loadDialogueReadState();
  }

  Future<void> _loadDialogueReadState() async {
    _readStateFile = await _getDialogueReadStateFile();
    if (await _readStateFile.exists()) {
      readStateFileContents = await _readStateFile.readAsString();
    }
  }

  Future<File> _getDialogueReadStateFile() async {
    final directory = await getApplicationCacheDirectory();
    File file = File('${directory.path}/dialogue_read_state.txt');
    DebugLog.info('Read dialog read state file in ${file.path}');
    return file;
  }

  Future<void> _loadConversations() async {
    try {
      String data =
          await rootBundle.loadString('assets/dialogue/dialogue.json');
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
          PopupMenuButton(
            //splashRadius: 10.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.theme.dividerColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Seen".i18n), onTap: () {}),
              PopupMenuItem(child: Text("Most popular".i18n), onTap: () {}),
              PopupMenuItem(child: Text("Newest".i18n), onTap: () {}),
              const PopupMenuItem(
                enabled: false,
                height: 0,
                child: WaveDivider(
                  thickness: .3,
                ),
              ),
              PopupMenuItem(child: Text("All".i18n), onTap: () {}),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          final conversationMd5 = Md5Generator.composeMd5IdForDialogueReadState(
              fromConversationDescription: conversation.description);
          bool isRead = readStateFileContents.contains(conversationMd5);
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
                            isRead: isRead,
                          )));
            },
            trailing: isRead
                ? Icon(
                    Icons.check_circle_outline,
                    color: context.theme.colorScheme.primary,
                  )
                : SizedBox.shrink(),
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
                  isRead: false,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
