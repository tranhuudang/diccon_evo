import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddNewDialogue extends StatefulWidget {
  const AddNewDialogue({super.key});

  @override
  _AddNewDialogueState createState() => _AddNewDialogueState();
}

class _AddNewDialogueState extends State<AddNewDialogue> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _listController = TextEditingController();
  final TextEditingController _singleController = TextEditingController();

  void _addListOfConversations() async {
    if (_formKey.currentState!.validate()) {
      try {
        List<dynamic> conversations = jsonDecode(_listController.text);
        for (var conversation in conversations) {
          await FirebaseFirestore.instance
              .collection('Dialogue')
              .doc('Conversations')
              .collection('Conversations')
              .add(conversation);
        }
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conversations added successfully')));
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding conversations: $e')));
      }
    }
  }

  void _addSingleConversation() async {
    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> conversation = jsonDecode(_singleController.text);
        await FirebaseFirestore.instance
            .collection('Dialogue')
            .doc('Conversations')
            .collection('Conversations')
            .add(conversation);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Conversation added successfully')));
        _formKey.currentState!.reset();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding conversation: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Conversations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _listController,
                decoration: const InputDecoration(labelText: 'List of Conversations (JSON format)'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a list of conversations';
                  }
                  try {
                    jsonDecode(value);
                  } catch (e) {
                    return 'Invalid JSON format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addListOfConversations,
                child: const Text('Add List of Conversations'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _singleController,
                decoration: const InputDecoration(labelText: 'Single Conversation (JSON format)'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a conversation';
                  }
                  try {
                    jsonDecode(value);
                  } catch (e) {
                    return 'Invalid JSON format';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _addSingleConversation,
                child: const Text('Add Single Conversation'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
