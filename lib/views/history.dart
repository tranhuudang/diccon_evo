import 'package:diccon_evo/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../components/history_tile.dart';
import '../global.dart';
import '../models/word.dart';
import 'package:diccon_evo/viewModels/file_handler.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  @override
  void initState() {
    loadHistory();
    super.initState();
  }

  List<Word> words = [];
  void loadHistory() async {
    words = await FileHandler.readHistory();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: Global.HISTORY, icon: Icons.history, actions: [
        IconButton(
            onPressed: () {
              words.sort((a, b) => a.word.compareTo(b.word));
              setState(() {});
            },
            icon: const Icon(Icons.sort_by_alpha)),
        PopupMenuButton(
          //splashRadius: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(16.0),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: const Text("Reverse List"),
              onTap: () async {
                words = words.reversed.toList();

                setState(() {});
              },
            ),
            PopupMenuItem(
              child: const Text("Clear all"),
              onTap: () async {},
            ),
          ],
        ),
      ]),
      body: Column(
        children: [
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
      ),
    );
  }
}
