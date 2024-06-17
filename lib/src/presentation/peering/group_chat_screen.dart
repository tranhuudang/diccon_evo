import 'package:diccon_evo/src/presentation/peering/utils.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  final TextEditingController messageController = TextEditingController();

  GroupChatScreen({required this.groupId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .where('group_id', isEqualTo: groupId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                List<DocumentSnapshot> docs = snapshot.data!.docs;

                List<Widget> messages = docs
                    .map((doc) => Message(
                  text: doc['text'],
                  sender: doc['sender'],
                ))
                    .toList();

                return ListView(
                  reverse: true,
                  children: messages,
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(hintText: 'Enter a message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () async {
                  if (messageController.text.isNotEmpty) {
                    await sendMessage(groupId, messageController.text, 'User'); // Replace 'User' with actual user ID
                    messageController.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final String sender;

  Message({required this.text, required this.sender});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sender),
      subtitle: Text(text),
    );
  }
}
