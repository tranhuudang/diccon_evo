import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class BrickWallButtons extends StatelessWidget {
  final List<String> listString;
  final Color? borderColor;
  final Color? textColor;
  const BrickWallButtons(
      {super.key, required this.listString, this.borderColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    final chatListBloc = context.read<ChatListBloc>();
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 48, top: 8, right: 16, bottom: 8),
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.0,
            runSpacing: 8.0,
            children: listString.map((String item) {
              return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color:
                          borderColor ?? context.theme.colorScheme.primary,
                    ),
                    //color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    onPressed: () {
                      chatListBloc.add(AddUserMessage(providedWord: item));
                      chatListBloc.add(AddTranslation(providedWord: item));
                    },
                    child: Text(
                      item,
                      style: TextStyle(
                          color: textColor ??
                              context.theme.colorScheme.primary),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
