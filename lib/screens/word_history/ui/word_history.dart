import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../../models/word.dart';
import '../../components/circle_button.dart';
import '../cubit/word_history_list_cubit.dart';
import 'history_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final historyListCubit = context.read<HistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<HistoryListCubit, List<Word>>(
          builder: (context, state) {
            if (state.isEmpty) {
              historyListCubit.loadHistory();
              return   Column(
                children: [
                  /// Header
                  HistoryHeader(historyListCubit: historyListCubit),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(
                            Icons.broken_image,
                            color: Colors.black45,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            "History is empty".i18n,
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

class HistoryHeader extends StatelessWidget {
  const HistoryHeader({
    super.key,
    required this.historyListCubit,
  });

  final HistoryListCubit historyListCubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom : 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleButton(
              iconData: Icons.arrow_back,
              onTap: () {
                Navigator.pop(context);
              }),
          const SizedBox(width: 16,),
          Text("History".i18n, style: const TextStyle(fontSize: 28)),
          Spacer(),
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
                child:  Text("Reverse List".i18n),
                onTap: () => historyListCubit.sortReverse(),
              ),
              PopupMenuItem(
                child:  Text("Clear all".i18n),
                onTap: () => historyListCubit.clearHistory(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

