import 'package:flutter/material.dart';

class LearningPageItem extends StatelessWidget {
  final int? currentIndex, totalIndex;
  final String word, phonetic, vietnamese;
  const LearningPageItem({
    super.key,
    required this.word,
    required this.phonetic,
    required this.vietnamese,
    this.currentIndex,
    this.totalIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
                  style: const TextStyle(
                      fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(phonetic),
                Text(vietnamese),
              ],
            ),
          ),
        ),
        Positioned(
          left: -50,
          top: -10,
          child: Text(
            word,
            style: const TextStyle(
                fontSize: 150,
                fontWeight: FontWeight.bold,
                color: Colors.white10,
                overflow: TextOverflow.fade),
          ),
        ),
        Positioned(
          bottom: 5,
          left: 80,
          child: Text(
            word,
            style: const TextStyle(
                fontSize: 100,
                fontWeight: FontWeight.bold,
                color: Colors.white10),
          ),
        ),
        currentIndex != null
            ? Positioned(
                top: 16,
                right: 16,
                child: Text("$currentIndex/$totalIndex"),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}