import 'package:diccon_evo/screens/dictionary/bloc/chat_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.word,
  });

  final String word;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).primaryTextTheme;
    final chatListBloc = context.read<ChatListBloc>();

    return Container(
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
              width: 2,
              color: Color.fromRGBO(128, 128, 128, 0.1),
            )
        ),
      ),
      child: ListTile(
        onTap: (){
          chatListBloc.add(AddUserMessage(providedWord: word));
          chatListBloc.add(AddLocalTranslation(providedWord: word));
          Navigator.pop(context);
        },
        title: Text(
          word,
          style: textTheme.titleMedium
        ),
        // trailing: Icon(
        //   Icons.chevron_right_rounded,
        //   color: Colors.grey[400],
        // ),
      ),
    );
  }
}