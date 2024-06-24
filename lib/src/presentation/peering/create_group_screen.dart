import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/peering/components/join_a_group.dart';
import 'package:diccon_evo/src/presentation/peering/components/your_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../presentation.dart';

class CreateGroupScreen extends StatelessWidget {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController membersController = TextEditingController();

  CreateGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Section(
              title: 'Create new group',
              children: [
                TextField(
                  controller: groupNameController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16, right: 50),
                    hintText: 'Group name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
                8.height,
                TextField(
                  controller: membersController,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(left: 16, right: 50),
                    hintText: 'Member IDs (comma-separated)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                  child: const Text('Create Group'),
                ),
              ],
            ),
            const JoinAGroupSection(),
            const YourIdSection()
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
      'isFile': false
    });
  }
}
