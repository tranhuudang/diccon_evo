import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/your_peers/ui/components/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../presentation.dart';
import '../components/components.dart';

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

                    return ListView.builder(
                      addAutomaticKeepAlives: true,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      reverse: true,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        var doc = docs[index];
                        if (doc['isImage']) {
                          return ImageBubble(
                            imageUrl: doc['text'],
                            senderId: doc['senderId'],
                            senderName: doc['senderName'],
                          );
                        }
                        if (doc['isVideo']) {
                          final fileName = extractFileName(doc['text']);
                          return VideoBubble(
                            fileName: fileName,
                            videoUrl: doc['text'],
                            senderId: doc['senderId'],
                            senderName: doc['senderName'],
                          );
                        }
                        if (doc['isFile']) {
                          final fileName = extractFileName(doc['text']);
                          return FileBubble(
                            fileName: fileName,
                            downloadUrl: doc['text'],
                            senderId: doc['senderId'],
                            senderName: doc['senderName'],
                          );
                        }
                        if (doc['isAudio']) {
                          final fileName = extractFileName(doc['text']);
                          return AudioBubble(
                            fileName: fileName,
                            audioUrl: doc['text'],
                            senderId: doc['senderId'],
                            senderName: doc['senderName'],
                          );
                        }
                        return TextBubble(
                          text: doc['text'],
                          senderId: doc['senderId'],
                          senderName: doc['senderName'],
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    state.params.isUploadingAttachFile
                        ? const SizedBox(
                      width: 48,
                      height: 48,
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                        : IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return SizedBox(
                                        height: 260,
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ListView(
                                            //mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                leading:
                                                    const Icon(Icons.image),
                                                title: Text('Add Image'.i18n),
                                                onTap: () {
                                                  groupChatBloc.add(
                                                      AddImageEvent(groupId));
                                                  // We using Navigator.pop instead of context.pop as it causing error
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons
                                                    .video_collection_outlined),
                                                title: Text('Add Video'.i18n),
                                                onTap: () {
                                                  groupChatBloc.add(
                                                      AddVideoEvent(groupId));

                                                  // We using Navigator.pop instead of context.pop as it causing error
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.audio_file_outlined),
                                                title: Text('Add Audio'.i18n),
                                                onTap: () {
                                                  groupChatBloc.add(
                                                      AddAudioEvent(groupId));
                                                  // We using Navigator.pop instead of context.pop as it causing error
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.attach_file),
                                                title: Text('Add File'.i18n),
                                                onTap: () {
                                                  groupChatBloc.add(
                                                      AddFileEvent(groupId));
                                                  // We using Navigator.pop instead of context.pop as it causing error
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ));
                                  });
                            },
                            icon: const Icon(Icons.add_circle_outline)),
                    Expanded(
                      child: TextField(
                        onSubmitted: (String text) {
                          groupChatBloc
                              .add(SendTextMessageEvent(groupId: groupId));
                        },
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
