import 'package:diccon_evo/config/responsive.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:flutter/material.dart';
import '../cubit/word_history_list_cubit.dart';
import 'components/history_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordHistoryView extends StatefulWidget {
  const WordHistoryView({super.key});

  @override
  State<WordHistoryView> createState() => _WordHistoryViewState();
}
class _WordHistoryViewState extends State<WordHistoryView> {
  final historyListCubit = HistoryListCubit();

  @override
  void initState(){
    historyListCubit.loadHistory();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            BlocBuilder<HistoryListCubit, List<String>>(
              bloc: historyListCubit,
              builder: (context, state) {
                if (state.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Image(
                          image: AssetImage('assets/stickers/history.png'),
                          width: 200,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "History is empty".i18n,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        const SizedBox().mediumHeight(),
                        Opacity(
                          opacity: 0.5,
                          child: Text(
                            "SubSentenceInWordHistory".i18n,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Responsive(
                    useDefaultPadding: false,
                    smallSizeDevice: body(state: state, bodyPadding: const EdgeInsets.only(left: 16, top: 60, right: 16, bottom: 16),),
                    mediumSizeDevice: body( state: state, bodyPadding: const EdgeInsets.only(left: 100, top: 60, right: 100, bottom: 16),),
                    largeSizeDevice: body(state: state, bodyPadding: const EdgeInsets.only(left: 200, top: 60, right: 200, bottom: 16),),
                  );
                }
              },
            ),
            Header(
              title: "History".i18n,
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
          ],
        ),
      ),
    );
  }

  ListView body({required List<String> state, required EdgeInsets bodyPadding}) {
    return ListView.builder(
                    padding: bodyPadding,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      final word = state[index];
                      return HistoryTile(word: word);
                    },
                  );
  }
}
