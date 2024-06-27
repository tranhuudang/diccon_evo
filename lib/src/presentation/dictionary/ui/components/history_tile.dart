import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({
    super.key,
    required this.word,
    required this.onEdit, required this.wordHistoryBloc,
  });

  final String word;
  final bool onEdit;
  final WordHistoryBloc wordHistoryBloc;


  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
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
          chatListBloc.add(AddUserMessageEvent(providedWord: word));
          chatListBloc.add(GetBasicTranslationEvent(providedWord: word));
          Navigator.pop(context);
        },
        title: Text(
          maxLines: 2,
          word,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              color: context.theme.colorScheme.onBackground),
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
