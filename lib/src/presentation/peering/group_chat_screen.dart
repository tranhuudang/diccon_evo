import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/presentation/peering/group_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  final String groupName;
  final TextEditingController messageController = TextEditingController();

  GroupChatScreen({required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(groupName),
        actions: [
          IconButton(
              onPressed: () {
                var userId = FirebaseAuth.instance.currentUser?.uid ?? '';
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GroupInfoScreen(groupId: groupId, userId: userId)));
              },
              icon: Icon(Icons.more_vert))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Messages')
                  .where('group_id', isEqualTo: groupId)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());

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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16, right: 50),
                      hintText: 'Enter a message',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    final userId = auth.currentUser?.uid;
                    if (userId?.isEmpty != null) {
                      if (messageController.text.isNotEmpty) {
                        await sendMessage(groupId, messageController.text,
                            auth.currentUser?.displayName ?? 'Anonymous'); // Replace 'User' with actual user ID
                        messageController.clear();
                      }
                    }

                  },
                ),
              ],
            ),
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

Future<void> sendMessage(String groupId, String text, String senderId) async {
  await FirebaseFirestore.instance.collection('Messages').add({
    'group_id': groupId,
    'text': text,
    'sender': senderId,
    'timestamp': FieldValue.serverTimestamp(),
  });
}
