import 'package:diccon_evo/screens/dictionary/bloc/chat_list_bloc.dart';
import 'package:diccon_evo/screens/dictionary/bloc/word_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.word,
    required this.onEdit,
  });

  final String word;
  final bool onEdit;


  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    final wordHistoryBloc = context.read<WordHistoryBloc>();
    return Container(
      alignment: Alignment.center,
      constraints: const BoxConstraints(minHeight: 70),
      decoration: const BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 2,
          color: Color.fromRGBO(128, 128, 128, 0.1),
        )),
      ),
      child: ListTile(
        onTap: () {
          chatListBloc.add(AddUserMessage(providedWord: word));
          chatListBloc.add(AddLocalTranslation(providedWord: word));
          Navigator.pop(context);
        },
        title: Text(
          maxLines: 2,
          word,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Theme.of(context).colorScheme.onBackground),
        ),
        trailing: onEdit
            ? IconButton(
                icon: const Icon(Icons.delete_outline),
                onPressed: () {
                  wordHistoryBloc.add(RemoveWordOutOfHistory(wordToRemove: word));
                },
              )
            : null,
      ),
    );
  }
}
