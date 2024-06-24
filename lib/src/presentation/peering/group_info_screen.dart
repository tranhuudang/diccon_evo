import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class GroupInfoScreen extends StatefulWidget {
  final String groupId;
  final String userId;

  const GroupInfoScreen({super.key, required this.groupId, required this.userId});

  @override
  _GroupInfoScreenState createState() => _GroupInfoScreenState();
}

class _GroupInfoScreenState extends State<GroupInfoScreen> {
  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController newMemberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadGroupInfo();
  }

  void _loadGroupInfo() async {
    DocumentSnapshot groupSnapshot = await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.groupId)
        .get();

    setState(() {
      groupNameController.text = groupSnapshot['name'];
    });
  }

  void _updateGroupName() async {
    String newName = groupNameController.text.trim();
    if (newName.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(widget.groupId)
          .update({'name': newName});
    }
  }

  void _addMember() async {
    String newMemberId = newMemberController.text.trim();
    if (newMemberId.isNotEmpty) {
      DocumentReference groupRef =
      FirebaseFirestore.instance.collection('Groups').doc(widget.groupId);
      DocumentSnapshot groupSnapshot = await groupRef.get();
      List<String> members = List<String>.from(groupSnapshot['members']);
      if (!members.contains(newMemberId)) {
        members.add(newMemberId);
        await groupRef.update({'members': members});
        newMemberController.clear(); // Clear the text field after adding the member
      }
    }
  }

  void _removeMember(String memberId) async {
    DocumentReference groupRef =
    FirebaseFirestore.instance.collection('Groups').doc(widget.groupId);
    DocumentSnapshot groupSnapshot = await groupRef.get();
    List<String> members = List<String>.from(groupSnapshot['members']);
    if (members.contains(memberId)) {
      members.remove(memberId);
      await groupRef.update({'members': members});
    }
  }

  void _deleteGroup() async {
    await FirebaseFirestore.instance
        .collection('Groups')
        .doc(widget.groupId)
        .delete();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Info'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Groups')
            .doc(widget.groupId)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          DocumentSnapshot groupDoc = snapshot.data!;
          List<String> members = List<String>.from(groupDoc['members']);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Section(
                  title: 'Info',
                  children: [
                    Row(
                      children: [
                        const Text('Group Id'),

                        TextButton.icon(
                            icon: const Icon(Icons.copy),
                            onPressed: (){}, label: Text(widget.groupId)),
                      ],
                    ),
                    TextField(
                      controller: groupNameController,
                      decoration: InputDecoration(
                        labelText: 'Group Name',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.save),
                          onPressed: _updateGroupName,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),

                Section(
                  title: 'Members',
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: members.length,
                      itemBuilder: (context, index) {
                        String memberId = members[index];
                        return ListTile(
                          title: Text(memberId),
                          trailing: widget.userId != memberId
                              ? IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () => _removeMember(memberId),
                          )
                              : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: newMemberController,
                      decoration: InputDecoration(
                        labelText: 'Add New Member ID',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _addMember,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){

                      _deleteGroup();},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white
                    ),
                    child: const Text('Delete Group'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}