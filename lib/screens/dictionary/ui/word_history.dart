import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:flutter/material.dart';
import '../../../config/local_traditions.dart';
import '../../../models/word.dart';
import '../cubit/word_history_list_cubit.dart';
import 'components/history_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordHistoryView extends StatelessWidget {
  const WordHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListCubit = context.read<HistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<HistoryListCubit, List<Word>>(
            builder: (context, state) {
              historyListCubit.loadHistory();

              if (state.isEmpty) {
                return Column(
                  children: [
                    /// Header
                    Header(
                      title: "History".i18n,
                      actions: [
                        IconButton(
                            onPressed: () => historyListCubit.sortAlphabet(),
                            icon: const Icon(Icons.sort_by_alpha)),
                        PopupMenuButton(
                          //splashRadius: 10.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Reverse List".i18n),
                              onTap: () => historyListCubit.sortReverse(),
                            ),
                            PopupMenuItem(
                              child: Text("Clear all".i18n),
                              onTap: () => historyListCubit.clearHistory(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Theme.of(context).cardColor,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "History is empty".i18n,
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Header(
                      title: "History".i18n,
                      actions: [
                        IconButton(
                            onPressed: () => historyListCubit.sortAlphabet(),
                            icon: const Icon(Icons.sort_by_alpha)),
                        PopupMenuButton(
                          //splashRadius: 10.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Reverse List".i18n),
                              onTap: () => historyListCubit.sortReverse(),
                            ),
                            PopupMenuItem(
                              child: Text("Clear all".i18n),
                              onTap: () => historyListCubit.clearHistory(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Tradition.heightSpacer,
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
      ),
    );
  }
}
