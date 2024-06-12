import 'package:diccon_evo/src/presentation/solo_conversation/dialogue_screen.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for rootBundle
import '../../domain/entities/solo_conversation/solo_conversation.dart';

class SoloConversationView extends StatefulWidget {
  @override
  _SoloConversationViewState createState() => _SoloConversationViewState();
}

class _SoloConversationViewState extends State<SoloConversationView> {
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
        title: Text('Conversations'),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            title: Text(conversation.title),
            subtitle: Text(conversation.hashtags.join(', ')),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DialogueScreen(conversation: conversation)));
            },
          );
        },
      ),
    );
  }
}
