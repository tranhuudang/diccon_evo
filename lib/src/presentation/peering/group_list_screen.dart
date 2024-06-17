import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'group_chat_screen.dart';

class GroupListScreen extends StatelessWidget {
  final String userId;

  GroupListScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Groups'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('groups')
            .where('members', arrayContains: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          List<DocumentSnapshot> docs = snapshot.data!.docs;

          return ListView(
            children: docs
                .map((doc) => ListTile(
              title: Text(doc['name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupChatScreen(groupId: doc.id),
                  ),
                );
              },
            ))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navigate to a screen to create a new group
        },
      ),
    );
  }
}
