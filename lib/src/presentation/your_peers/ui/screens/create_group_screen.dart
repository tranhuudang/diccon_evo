import 'package:diccon_evo/src/core/core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/components.dart';
import '../../../presentation.dart';

class CreateGroupScreen extends StatefulWidget {

  const CreateGroupScreen({super.key});

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController membersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'.i18n),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Section(
              title: 'Create new group'.i18n,
              children: [
                TextField(
                  controller: groupNameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, right: 50),
                    hintText: 'Group name'.i18n,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                  ),
                ),
                8.height,
                TextField(
                  controller: membersController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, right: 50),
                    hintText: 'Member IDs (comma-separated)'.i18n,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                    ),
                    disabledBorder: const OutlineInputBorder(
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
                    List<String> members = membersController.text.trim().isEmpty
                        ? []
                        : membersController.text.trim().split(',').map((e) => e.trim()).toList();

                    // Insert current user's ID if not already present
                    members.insert(0, auth.currentUser?.uid ?? '');

                    // Filter out any empty strings from members
                    members = members.where((member) => member.isNotEmpty).toList();

                    if (groupName.isNotEmpty && members.isNotEmpty) {
                      await createGroup(groupName, members);
                      Navigator.pop(context); // Return to the previous screen
                    } else {
                      // Show an error message or handle empty fields
                      // For example, ScaffoldMessenger.of(context).showSnackBar(...)
                    }
                  },
                  child: Text('Create Group'.i18n),
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
    String userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    DocumentReference groupRef = await FirebaseFirestore.instance.collection('Groups').add({
      'name': groupName,
      'members': members,
      'creator': userId,
      'created_at': FieldValue.serverTimestamp(),
    });
  }
}
