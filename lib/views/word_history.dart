import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../cubits/word_history_list_cubit.dart';
import '../views/components/history_tile.dart';
import '../global.dart';
import '../models/word.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListCubit = context.read<HistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: Header(
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
            ]),
        body: BlocBuilder<HistoryListCubit, List<Word>>(
          builder: (context, state) {
            if (state.isEmpty) {
              historyListCubit.loadHistory();
              return  const Column(
                children: [
                  Expanded(
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

