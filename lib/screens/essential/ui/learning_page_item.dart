import 'package:flutter/material.dart';
class LearningPageItem extends StatelessWidget {
  final String word, phonetic, vietnamese;
  const LearningPageItem({
    super.key, required this.word, required this.phonetic, required this.vietnamese,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).primaryColor),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  word,
                  style: TextStyle(fontSize: 30),
                ),
                Text(phonetic),
                Text(vietnamese),
              ],
            ),
          )),
    );
  }
}
