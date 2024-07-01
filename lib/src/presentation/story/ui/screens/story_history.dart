import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import '../../bloc/story_history_bloc.dart';

class StoryListHistoryView extends StatefulWidget {
  const StoryListHistoryView({super.key});

  @override
  State<StoryListHistoryView> createState() => _StoryListHistoryViewState();
}

class _StoryListHistoryViewState extends State<StoryListHistoryView> {
  @override
  Widget build(BuildContext context) {
    final storyHistoryBloc = context.read<StoryHistoryBloc>();
    return RefreshIndicator(
      displacement: 60,
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
        storyHistoryBloc.add(StoryHistoryForceReload());
      },
      child: BlocConsumer<StoryHistoryBloc, StoryHistoryState>(
        listener: (BuildContext context, StoryHistoryState state) {},
        buildWhen: (previous, current) => current is! StoryHistoryActionState,
        listenWhen: (previous, current) => current is StoryHistoryActionState,
        builder: (context, state) {
          switch (state) {
            case StoryHistoryUpdated _:
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "History".i18n,
                  ),
                  actions: [
                    IconButton(onPressed: (){
                      storyHistoryBloc.add(StoryHistoryForceReload());
                    }, icon: const Icon(Icons.refresh)),
                    IconButton(
                        onPressed: () => storyHistoryBloc.add(
                            StoryHistorySortAlphabet(stories: state.stories)),
                        icon: const Icon(Icons.sort_by_alpha)),
                    PopupMenuButton(
                      //splashRadius: 10.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: context.theme.dividerColor),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: Text("Elementary".i18n),
                          onTap: () =>
                              storyHistoryBloc.add(StoryHistorySortElementary()),
                        ),
                        PopupMenuItem(
                          child: Text("Intermediate".i18n),
                          onTap: () => storyHistoryBloc
                              .add(StoryHistorySortIntermediate()),
                        ),
                        PopupMenuItem(
                          child: Text("Advanced".i18n),
                          onTap: () =>
                              storyHistoryBloc.add(StoryHistorySortAdvanced()),
                        ),
                        const PopupMenuItem(
                          enabled: false,
                          height: 0,
                          child: Divider(),
                        ),
                        PopupMenuItem(
                          child: Text("All".i18n),
                          onTap: () => storyHistoryBloc.add(StoryHistoryGetAll()),
                        ),
                      ],
                    ),
                  ],
                ),
                body: LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth;
                    int crossAxisCount;
                    // Adjust the number of columns based on the available width
                    if (maxWidth >= 1600) {
                      crossAxisCount = 5;
                    } else if (maxWidth >= 1300) {
                      crossAxisCount = 4;
                    } else if (maxWidth >= 1000) {
                      crossAxisCount = 3;
                    } else if (maxWidth >= 700) {
                      crossAxisCount = 2;
                    } else {
                      crossAxisCount = 1;
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.stories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        crossAxisCount: crossAxisCount,
                        mainAxisExtent: 120,
                        childAspectRatio:
                            7 / 3, // Adjust the aspect ratio as needed
                      ),
                      itemBuilder: (context, index) {
                        return ReadingTile(
                          story: state.stories[index],
                          onTap: () {
                            context.pushNamed(RouterConstants.readingSpace,
                                extra: state.stories[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              );
            case StoryHistoryEmptyState _:
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "History".i18n,
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            context.theme.colorScheme.primary, BlendMode.srcIn),
                        child: Image(
                          image: AssetImage(LocalDirectory.historyIllustration),
                          height: 200,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text("History is empty".i18n,
                          style: context.theme.textTheme.titleMedium),
                      8.height,
                      Opacity(
                        opacity: 0.5,
                        child: Text(
                          "SubSentenceInStoryHistory".i18n,
                          style: context.theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case StoryHistoryErrorState _:
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "History".i18n,
                  ),
                ),
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.broken_image,
                        color: Colors.orange,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Error trying to get history.".i18n,
                        style: TextStyle(
                            color: context.theme.highlightColor, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            default:
              storyHistoryBloc.add(FetchStoryHistoryFromFirestore());
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "History".i18n,
                  ),
                ),
                body: const Center(
                  child: SizedBox(
                      height: 50, width: 50, child: CircularProgressIndicator()),
                ),
              );
          }
        },
      ),
    );
  }
}
