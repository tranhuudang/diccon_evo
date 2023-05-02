import 'package:flutter/material.dart';
class Word {
  final String word;
  final String pronunciation;
  final String meaning;
  final String type;

  const Word({
    required this.word,
    required this.pronunciation,
    required this.meaning,
    required this.type,
  });
}

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key, required this.words}) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        return ListTile(
          title: Text(
            word.word,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(word.pronunciation),
              SizedBox(height: 4),
              Text(
                '${word.type} - ${word.meaning}',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
      },
    );
  }
}
