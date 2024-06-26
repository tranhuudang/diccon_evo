import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Events
abstract class GroupInfoEvent {}

class LoadGroupInfoEvent extends GroupInfoEvent {
  final String groupId;

  LoadGroupInfoEvent(this.groupId);
}

class UpdateGroupNameEvent extends GroupInfoEvent {
  final String groupId;
  final String newName;

  UpdateGroupNameEvent(this.groupId, this.newName);
}

class AddMemberEvent extends GroupInfoEvent {
  final String groupId;
  final String newMemberId;

  AddMemberEvent(this.groupId, this.newMemberId);
}

class RemoveMemberEvent extends GroupInfoEvent {
  final String groupId;
  final String memberId;

  RemoveMemberEvent(this.groupId, this.memberId);
}

class DeleteGroupEvent extends GroupInfoEvent {
  final String groupId;

  DeleteGroupEvent(this.groupId);
}

// State
class GroupInfoState {
  final DocumentSnapshot? groupSnapshot;
  final String? error;

  GroupInfoState({this.groupSnapshot, this.error});
}

class GroupInfoActionState extends GroupInfoState{}
class GroupNameChangedState extends GroupInfoState{}

// Bloc
class GroupInfoBloc extends Bloc<GroupInfoEvent, GroupInfoState> {
  final String groupId;
  final String userId;

  GroupInfoBloc(this.groupId, this.userId) : super(GroupInfoState()) {
    on<LoadGroupInfoEvent>(_loadGroupInfo);
    on<UpdateGroupNameEvent>(_updateGroupName);
    on<AddMemberEvent>(_addMember);
    on<RemoveMemberEvent>(_removeMember);
    on<DeleteGroupEvent>(_deleteGroup);
  }

  final TextEditingController groupNameController = TextEditingController();
  final TextEditingController addMemberTextController = TextEditingController();


  FutureOr<void> _loadGroupInfo(
      LoadGroupInfoEvent event, Emitter<GroupInfoState> emit) async {
    try {
      DocumentSnapshot groupSnapshot = await FirebaseFirestore.instance
          .collection('Groups')
          .doc(event.groupId)
          .get();
      groupNameController.text = groupSnapshot['name'];
      emit(GroupInfoState(groupSnapshot: groupSnapshot));
    } catch (e) {
      emit(GroupInfoState(error: 'Failed to load group info: $e'));
    }
  }

  FutureOr<void> _updateGroupName(
      UpdateGroupNameEvent event, Emitter<GroupInfoState> emit) async {
    try {
      String newName = event.newName.trim();
      if (newName.isNotEmpty) {
        await FirebaseFirestore.instance
            .collection('Groups')
            .doc(event.groupId)
            .update({'name': newName});
        add(LoadGroupInfoEvent(event.groupId));
        emit(GroupNameChangedState());
      }
    } catch (e) {
      emit(GroupInfoState(error: 'Failed to update group name: $e'));
    }
  }

  FutureOr<void> _addMember(
      AddMemberEvent event, Emitter<GroupInfoState> emit) async {
    try {
      String newMemberId = event.newMemberId.trim();
      if (newMemberId.isNotEmpty) {
        DocumentReference groupRef =
            FirebaseFirestore.instance.collection('Groups').doc(event.groupId);
        DocumentSnapshot groupSnapshot = await groupRef.get();
        List<String> members = List<String>.from(groupSnapshot['members']);
        if (!members.contains(newMemberId)) {
          members.add(newMemberId);
          await groupRef.update({'members': members});
          add(LoadGroupInfoEvent(event.groupId)); // Reload group info after update
        }
        addMemberTextController.text = '';
      }
    } catch (e) {
      emit(GroupInfoState(error: 'Failed to add member: $e'));
    }
  }

  FutureOr<void> _removeMember(
      RemoveMemberEvent event, Emitter<GroupInfoState> emit) async {
    try {
      DocumentReference groupRef =
          FirebaseFirestore.instance.collection('Groups').doc(event.groupId);
      DocumentSnapshot groupSnapshot = await groupRef.get();
      List<String> members = List<String>.from(groupSnapshot['members']);
      if (members.contains(event.memberId)) {
        members.remove(event.memberId);
        await groupRef.update({'members': members});
        add(LoadGroupInfoEvent(event.groupId)); // Reload group info after update
      }
    } catch (e) {
      emit(GroupInfoState(error: 'Failed to remove member: $e'));
    }
  }

  FutureOr<void> _deleteGroup(
      DeleteGroupEvent event, Emitter<GroupInfoState> emit) async {
    try {
      await FirebaseFirestore.instance
          .collection('Groups')
          .doc(event.groupId)
          .delete();
      emit(GroupInfoState()); // Reset state after deletion
    } catch (e) {
      emit(GroupInfoState(error: 'Failed to delete group: $e'));
    }
  }
}
