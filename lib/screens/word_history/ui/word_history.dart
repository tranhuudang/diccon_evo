import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../models/word.dart';
import '../cubit/word_history_list_cubit.dart';
import 'components/history_header.dart';
import 'history_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordHistoryView extends StatelessWidget {
  const WordHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListCubit = context.read<HistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HistoryListCubit, List<Word>>(
          builder: (context, state) {
            if (state.isEmpty) {
              historyListCubit.loadHistory();
              return Column(
                children: [
                  /// Header
                  HistoryHeader(historyListCubit: historyListCubit),
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
                  HistoryHeader(historyListCubit: historyListCubit),
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
