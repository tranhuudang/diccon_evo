import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../presentation.dart';

class JoinAGroupSection extends StatefulWidget {
  const JoinAGroupSection({
    super.key,
  });

  @override
  State<JoinAGroupSection> createState() => _JoinAGroupSectionState();
}

class _JoinAGroupSectionState extends State<JoinAGroupSection> {
  final TextEditingController groupJoinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Section(
      title: 'Join a group'.i18n,
      children: [
        const SizedBox(height: 8),
        TextField(
          controller: groupJoinController,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 16, right: 50),
            hintText: 'Enter group ID'.i18n,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton(
          onPressed: () async {
            String groupId = groupJoinController.text.trim();
            if (groupId.isNotEmpty) {
              DocumentReference groupRef =
                  FirebaseFirestore.instance.collection('Groups').doc(groupId);
              DocumentSnapshot groupSnapshot = await groupRef.get();
              String? userId = FirebaseAuth.instance.currentUser?.uid;
              if (groupSnapshot.exists) {
                List<String> members =
                    List<String>.from(groupSnapshot['members']);
                if (!members.contains(userId)) {
                  members.add(userId!);
                  await groupRef.update({'members': members});
                }
              } else {
                // Handle the case where the group ID doesn't exist
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Group ID not found'.i18n)),
                );
              }
            }
          },
          child: Text('Join'.i18n),
        ),
      ],
    );
  }
}
