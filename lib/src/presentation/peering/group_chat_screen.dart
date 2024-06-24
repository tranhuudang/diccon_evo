import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/presentation/peering/group_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  final String groupName;
  final TextEditingController messageController = TextEditingController();

  GroupChatScreen({super.key, required this.groupId, required this.groupName});

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
              icon: const Icon(Icons.more_vert))
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
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<DocumentSnapshot> docs = snapshot.data!.docs;

                List<Widget> messages = docs
                    .map((doc) => Message(
                          text: doc['text'],
                          sender: doc['sender'],
                          isFile: doc['isFile'] ?? false,
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
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () async {
                    // Request storage permission
                    PermissionStatus status =
                    await Permission.storage.request();

                    if (status.isGranted) {
                      FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;
                        if (file.size <= 10 * 1024 * 1024) {
                          // 10MB limit
                          await uploadFile(file, groupId);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'File size exceeds 10MB limit. Please select a smaller file.')),
                          );
                        }
                      }
                    }
                  },
                ),
                
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 16, right: 50),
                      hintText: 'Enter a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    final userId = auth.currentUser?.uid;
                    if (userId?.isEmpty != null) {
                      if (messageController.text.isNotEmpty) {
                        await sendMessage(groupId, messageController.text,
                            auth.currentUser?.displayName ?? 'Anonymous');
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

  Future<void> uploadFile(PlatformFile file, String groupId) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('ChatFiles').child(file.name);
    UploadTask uploadTask = ref.putFile(File(file.path!));

    final TaskSnapshot taskSnapshot = await uploadTask;
    final String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await sendMessage(groupId, downloadUrl,
        FirebaseAuth.instance.currentUser?.displayName ?? 'Anonymous',
        isFile: true);
  }
}

class Message extends StatelessWidget {
  final String text;
  final String sender;
  final bool isFile;

  const Message(
      {super.key,
      required this.text,
      required this.sender,
      this.isFile = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(sender),
      subtitle: isFile
          ? InkWell(
              child: Text('File: $text', style: TextStyle(color: Colors.blue)),
              onTap: () => launchURL(text),
            )
          : Text(text),
    );
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

Future<void> sendMessage(String groupId, String text, String senderId,
    {bool isFile = false}) async {
  await FirebaseFirestore.instance.collection('Messages').add({
    'group_id': groupId,
    'text': text,
    'sender': senderId,
    'timestamp': FieldValue.serverTimestamp(),
    'isFile': isFile,
  });
}
