import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../presentation.dart';
class JoinAGroup extends StatefulWidget {
  const JoinAGroup({
    super.key,
  });

  @override
  State<JoinAGroup> createState() => _JoinAGroupState();
}

class _JoinAGroupState extends State<JoinAGroup> {
  final TextEditingController groupJoinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Join a group',
      children: [
        SizedBox(height: 8),
        TextField(
          controller: groupJoinController,
          decoration: InputDecoration(
            hintText: 'Enter group ID',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 8),
        FilledButton(
          onPressed: () async {
            String groupId = groupJoinController.text.trim();
            if (groupId.isNotEmpty) {
              DocumentReference groupRef = FirebaseFirestore.instance.collection('Groups').doc(groupId);
              DocumentSnapshot groupSnapshot = await groupRef.get();
              String? userId = FirebaseAuth.instance.currentUser?.uid;
              if (groupSnapshot.exists) {
                List<String> members = List<String>.from(groupSnapshot['members']);
                if (!members.contains(userId)) {
                  members.add(userId!);
                  await groupRef.update({'members': members});
                }
              } else {
                // Handle the case where the group ID doesn't exist
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Group ID not found')),
                );
              }
            }
          },
          child: Text('Join'),
        ),
      ],
    );
  }
}
