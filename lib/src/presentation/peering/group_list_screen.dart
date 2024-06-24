import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../presentation.dart';
import 'components/join_a_group.dart';
import 'create_group_screen.dart';
import 'group_chat_screen.dart'; // Import the new screen

class GroupListScreen extends StatelessWidget {
  final String userId;

  GroupListScreen({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Groups')
          .where('members', arrayContains: userId)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData)
          return Center(child: CircularProgressIndicator());

        List<DocumentSnapshot> docs = snapshot.data!.docs;

        return Scaffold(
          appBar: AppBar(
            title: Text('Groups'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                if (docs.isEmpty)
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Section(
                          title: 'Create new group',
                          children: [
                            SizedBox(height: 8),
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  context.theme.colorScheme.primary,
                                  BlendMode.srcIn),
                              child: Image(
                                image: AssetImage(
                                    LocalDirectory.dictionaryIllustration),
                                height: 140,
                              ),
                            ),
                            Text(
                              'Welcome to groups, let\'s create your new group and share awesome things with your friends while you learn',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16),
                            FilledButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateGroupScreen(), // Pass userId to CreateGroupScreen
                                  ),
                                );
                              },
                              child: Text('Create a new group'),
                            ),
                          ],
                        ),
                        JoinAGroup(),
                      ],
                    ),
                  ),
                if (docs.isNotEmpty)
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    shrinkWrap: true,
                    children: docs.map(
                      (doc) {
                        int numberOfMembers =
                            List<String>.from(doc['members']).length;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    GroupChatScreen(groupId: doc.id, groupName: doc['name'],),
                              ),
                            );
                          },
                          child: Card(

                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                Text(doc['name'], style: context.theme.textTheme.titleMedium,),
                                8.height,
                                Text(numberOfMembers > 1
                                    ? '$numberOfMembers members'
                                    : '$numberOfMembers member')
                                                            ],
                                                          ),
                              )),
                        );
                      },
                    ).toList(),
                  )
              ],
            ),
          ),
          floatingActionButton: docs.isNotEmpty
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              CreateGroupScreen()), // Navigate to the new screen
                    );
                  },
                )
              : null,
        );
      },
    );
  }
}
