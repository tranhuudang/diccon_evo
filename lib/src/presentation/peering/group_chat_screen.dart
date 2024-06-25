import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/presentation/peering/data/bloc/group_bloc.dart';
import 'package:diccon_evo/src/presentation/peering/group_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'components/group_bubble.dart';

class GroupChatScreen extends StatelessWidget {
  final String groupId;
  final String groupName;

  const GroupChatScreen(
      {super.key, required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context) {
    final groupChatBloc = context.read<GroupChatBloc>();
    return BlocConsumer<GroupChatBloc, GroupChatState>(
      listenWhen: (previous, current) => current is GroupChatActionState,
      buildWhen: (previous, current) => current is! GroupChatActionState,
      listener: (BuildContext context, GroupChatState state) {
        if (state is AttachFileTooLargeState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'File size exceeds 10MB limit. Please select a smaller file.')),
          );
        }
      },
      builder: (context, state) {
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
                            builder: (context) => GroupInfoScreen(
                                groupId: groupId, userId: userId)));
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
                              isFile: doc['isFile'] ?? false,
                              senderId: doc['senderId'],
                              senderName: doc['senderName'],
                            ))
                        .toList();

                    return ListView(
                      padding: EdgeInsets.symmetric(horizontal: 16),
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
                    state.params.isUploadingAttachFile
                        ? const CircularProgressIndicator()
                        : IconButton(
                            icon: const Icon(Icons.attach_file),
                            onPressed: () async {
                              groupChatBloc.add(SendAttachFileEvent(groupId));
                            },
                          ),
                    Expanded(
                      child: TextField(
                        controller: groupChatBloc.messageController,
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
                      onPressed: () {
                        groupChatBloc
                            .add(SendTextMessageEvent(groupId: groupId));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Message extends StatelessWidget {
  final String text;
  final String senderId;
  final String senderName;
  final bool isFile;

  const Message(
      {super.key,
      required this.text,
      required this.senderId,
      required this.senderName,
      this.isFile = false});

  @override
  Widget build(BuildContext context) {
    if (senderId == FirebaseAuth.instance.currentUser!.uid) {
      return GroupUserBubble(
        text: text,
        senderId: senderId,
        senderName: senderName,
        isFile: isFile,
      );
    } else {
      return GroupGuestBubble(
        onTap: () {},
        text: text,
        senderId: senderId,
        senderName: senderName,
        isFile: isFile,
      );
    }
  }
}
