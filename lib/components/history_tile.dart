import 'package:flutter/material.dart';

import '../models/word.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.word,
  });

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
              width: 2,
              color: Color.fromRGBO(128, 128, 128, 0.1),
            )
        ),
      ),
      child: ListTile(
        title: Text(
          word.word,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(
          word.meaning!,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
        ),
        trailing: Icon(
          Icons.chevron_right_rounded,
          color: Colors.grey[400],
        ),
      ),
    );
  }
}