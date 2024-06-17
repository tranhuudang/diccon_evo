import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> sendMessage(String groupId, String text, String senderId) async {
  await FirebaseFirestore.instance.collection('messages').add({
    'group_id': groupId,
    'text': text,
    'sender': senderId,
    'timestamp': FieldValue.serverTimestamp(),
  });
}
