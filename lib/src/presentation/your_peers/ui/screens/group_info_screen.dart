import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class GroupInfoScreen extends StatelessWidget {
  final String groupId;
  final String userId;

  const GroupInfoScreen(
      {super.key, required this.groupId, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GroupInfoBloc(groupId, userId)..add(LoadGroupInfoEvent(groupId)),
      child: BlocConsumer<GroupInfoBloc, GroupInfoState>(
        listenWhen: (previous, current) => current is GroupInfoActionState,
        buildWhen: (previous, current) => current is !GroupInfoActionState,
        listener: (context, state){
          if (state is GroupNameChangedState){
            context.showSnackBar(content: 'Group name has changed');
          }
        },
        builder: (context, state) {
          if (state.error != null) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else if (state.groupSnapshot == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            DocumentSnapshot groupDoc = state.groupSnapshot!;
            List<String> members = List<String>.from(groupDoc['members']);

            return _buildGroupInfo(context, groupDoc, members);
          }
        },
      ),
    );
  }

  Widget _buildGroupInfo(
      BuildContext context, DocumentSnapshot groupDoc, List<String> members) {
    final groupInfoBloc = context.read<GroupInfoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Group Info'),
      ),
      body: SingleChildScrollView(
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
                      onPressed: () {},
                      label: Text(groupId),
                    ),
                  ],
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Group name'),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: groupInfoBloc.groupNameController,
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
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        context.read<GroupInfoBloc>().add(UpdateGroupNameEvent(
                            groupId, groupInfoBloc.groupNameController.text));
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            Section(
              title: 'Members',
              children: [
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    String memberId = members[index];
                    return ListTile(
                      title: userId == memberId
                          ? const Text('You')
                          : Text(memberId),
                      leading: Text('${index + 1}'),
                      trailing: userId != memberId
                          ? IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                context
                                    .read<GroupInfoBloc>()
                                    .add(RemoveMemberEvent(groupId, memberId));
                              },
                            )
                          : null,
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: groupInfoBloc.addMemberTextController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(left: 16, right: 50),
                          hintText: 'Add a new member ID',
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
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: () {
                        context.read<GroupInfoBloc>().add(AddMemberEvent(groupId,
                            groupInfoBloc.addMemberTextController.text.trim()));
                      },
                      child: const Text('Add'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
            Section(
              title: 'Manage group',
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<GroupInfoBloc>().add(DeleteGroupEvent(groupId));
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete Group'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
