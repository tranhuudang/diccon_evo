import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:wave_divider/wave_divider.dart';

class WordHistoryView extends StatefulWidget {
  const WordHistoryView({super.key});

  @override
  State<WordHistoryView> createState() => _WordHistoryViewState();
}

class _WordHistoryViewState extends State<WordHistoryView> {
  final _wordHistoryBloc = WordHistoryBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.surface,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text("History".i18n,),
        actions: [
          IconButton(
              onPressed: () =>
                  _wordHistoryBloc.add(SortAlphabetWordHistory()),
              icon: const Icon(Icons.sort_by_alpha)),
          PopupMenuButton(
            //splashRadius: 10.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.theme.dividerColor),
              borderRadius: BorderRadius.circular(16.0),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Reverse".i18n),
                onTap: () =>
                    _wordHistoryBloc.add(SortReverseWordHistory()),
              ),
              const PopupMenuItem(
                height: 0,
                child: WaveDivider(
                  thickness: .3,
                ),
              ),
              PopupMenuItem(
                child: Text("Edit".i18n),
                onTap: () => _wordHistoryBloc.add(WordHistoryEditMode()),
              ),
            ],
          ),
        ],
      ),
      body: BlocBuilder<WordHistoryBloc, WordHistoryState>(
        bloc: _wordHistoryBloc,
        builder: (context, state) {
          switch (state) {
            case WordHistoryUpdated _:
              if (state.words.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Illustration(assetImage:
                      LocalDirectory.commonIllustration,),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "History is empty".i18n,
                        style: context.theme.textTheme.titleMedium,
                      ),
                      8.height,
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "SubSentenceInWordHistory".i18n,
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: state.words.length,
                  itemBuilder: (context, index) {
                    final word = state.words[index];
                    return HistoryTile(
                        word: word,
                        onEdit: state.isEdit!,
                        wordHistoryBloc: _wordHistoryBloc);
                  },
                );
              }
            default:
              _wordHistoryBloc.add(InitialWordHistory());
              return Container();
          }
        },
      ),
      bottomNavigationBar: BlocBuilder<WordHistoryBloc, WordHistoryState>(
          bloc: _wordHistoryBloc,
          builder: (context, state) {
            if (state.isEdit == true) {
              return BottomAppBar(
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    children: [
                      const Spacer(),
                      FilledButton.tonal(
                          onPressed: () {
                            context.showAlertDialog(
                                title: "Delete History".i18n,
                                content: "AskQuestionBeforeDelete".i18n,
                                action: () {
                                  _wordHistoryBloc.add(ClearAllWordHistory());
                                  _wordHistoryBloc
                                      .add(CloseWordHistoryEditMode());
                                });
                          },
                          child: Text("Clear all".i18n)),
                      8.width,
                      FilledButton.tonal(
                          onPressed: () {
                            _wordHistoryBloc.add(CloseWordHistoryEditMode());
                          },
                          child: Text("Close".i18n)),
                    ],
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          }),
    );
  }
}


