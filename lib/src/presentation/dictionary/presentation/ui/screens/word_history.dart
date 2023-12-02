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
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            BlocBuilder<WordHistoryBloc, WordHistoryState>(
              bloc: _wordHistoryBloc,
              builder: (context, state) {
                switch (state) {
                  case WordHistoryUpdated _:
                    if (state.words.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  context.theme.colorScheme.primary,
                                  BlendMode.srcIn),
                              child:  Image(
                                image: AssetImage(LocalDirectory.commonIllustration),
                                height: 200,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "History is empty".i18n,
                              style: context.theme.textTheme.titleMedium,
                            ),
                            const VerticalSpacing.medium(),
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
                        padding: const EdgeInsets.only(top: 60),
                        itemCount: state.words.length,
                        itemBuilder: (context, index) {
                          final word = state.words[index];
                          return HistoryTile(
                              word: word, onEdit: state.isEdit!, wordHistoryBloc : _wordHistoryBloc);
                        },
                      );
                    }
                  default:
                    _wordHistoryBloc.add(InitialWordHistory());
                    return Container();
                }
              },
            ),
            Header(
              title: "History".i18n,
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
                      child:  WaveDivider(thickness: .3,),

                    ),
                    PopupMenuItem(
                      child: Text("Edit".i18n),
                      onTap: () => _wordHistoryBloc.add(WordHistoryEditMode()),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BlocBuilder<WordHistoryBloc, WordHistoryState>(
            bloc: _wordHistoryBloc,
            builder: (context, state) {
          if (state.isEdit == true) {
            return BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    FilledButton.icon(onPressed: (){
                      context.showAlertDialog(
                          title: "Delete History".i18n,
                          content:
                          "AskQuestionBeforeDelete".i18n,
                          action: () {
                            _wordHistoryBloc.add(ClearAllWordHistory());
                            _wordHistoryBloc.add(CloseWordHistoryEditMode());

                          });
                    }, icon: const Icon(Icons.delete_outline), label: Text("Clear all".i18n)),
                    const Spacer(),
                    CircleButton(
                        iconData: Icons.close,
                        onTap: () {
                          _wordHistoryBloc.add(CloseWordHistoryEditMode());
                        })
                  ],
                ),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        }),
      ),
    );
  }
}
