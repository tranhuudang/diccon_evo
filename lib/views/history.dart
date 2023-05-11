import 'package:diccon_evo/components/header_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/history_tile.dart';
import '../global.dart';
import '../models/word.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key, required this.words}) : super(key: key);
  final List<Word> words;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        HeaderBox(title: Global.HISTORY, icon: Icons.history,
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.sort_by_alpha)),
          ],),
        Expanded(
          child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              final word = words[index];
              return HistoryTile(word: word);
            },
          ),
        ),
      ],
    );
  }
}


