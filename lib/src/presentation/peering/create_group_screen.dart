import 'package:diccon_evo/src/presentation/peering/components/join_a_group.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../presentation.dart';

class CreateGroupScreen extends StatelessWidget {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController membersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Section(
              title: 'Create new group',
              children: [
                TextField(
                  controller: groupNameController,
                  decoration: InputDecoration(hintText: 'Group Name'),
                ),
                TextField(
                  controller: membersController,
                  decoration: InputDecoration(hintText: 'Member IDs (comma-separated)'),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    FirebaseAuth auth = FirebaseAuth.instance;
                    String groupName = groupNameController.text.trim();
                    List<String> members = membersController.text.trim().split(',');
                    print('uid');
                    print(auth.currentUser?.uid );
                    members.insert(0, auth.currentUser?.uid ?? '');
                    if (groupName.isNotEmpty && members.isNotEmpty) {
                      await createGroup(groupName, members);
                      Navigator.pop(context); // Return to the previous screen
                    } else {
                      // Show an error message or handle empty fields
                    }
                  },
                  child: Text('Create Group'),
                ),
              ],
            ),
            JoinAGroup()
          ],
        ),
      ),
    );
  }

  Future<void> createGroup(String groupName, List<String> members) async {
    DocumentReference groupRef = await FirebaseFirestore.instance.collection('Groups').add({
      'name': groupName,
      'members': members,
      'created_at': FieldValue.serverTimestamp(),
    });

    // Optionally, add an initial welcome message
    await FirebaseFirestore.instance.collection('Messages').add({
      'group_id': groupRef.id,
      'text': 'Welcome to $groupName!',
      'sender': 'System',
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
