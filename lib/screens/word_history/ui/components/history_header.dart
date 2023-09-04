import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';


import '../../../components/circle_button.dart';
import '../../cubit/word_history_list_cubit.dart';class HistoryHeader extends StatelessWidget {
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
