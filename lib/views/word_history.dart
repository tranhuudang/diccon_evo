import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../cubits/history_list_cubit.dart';
import '../helpers/platform_check.dart';
import '../views/components/history_tile.dart';
import '../global.dart';
import '../models/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';

import 'components/window_title_bar.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListCubit = context.read<HistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: const WindowTileBar(),
        body: BlocBuilder<HistoryListCubit, List<Word>>(
          builder: (context, state) {
            if (state.isEmpty) {
              historyListCubit.loadHistory();
              return  Column(
                children: [
                  WordHistoryHeader(historyListCubit: historyListCubit),
                  const Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "History is empty",
                            style: TextStyle(color: Colors.black45, fontSize: 18),
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  WordHistoryHeader(historyListCubit: historyListCubit),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.length,
                      itemBuilder: (context, index) {
                        final word = state[index];
                        return HistoryTile(word: word);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class WordHistoryHeader extends StatelessWidget {
  const WordHistoryHeader({
    super.key,
    required this.historyListCubit,
  });

  final HistoryListCubit historyListCubit;

  @override
  Widget build(BuildContext context) {
    return Header(
        title: Global.HISTORY,
        iconButton: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
              onPressed: () => historyListCubit.sortAlphabet(),
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
                onTap: () => historyListCubit.sortReverse(),
              ),
              PopupMenuItem(
                child: const Text("Clear all"),
                onTap: () => historyListCubit.clearHistory(),
              ),
            ],
          ),
        ]);
  }
}
