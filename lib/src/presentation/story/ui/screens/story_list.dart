import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../bloc/story_list_bloc.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyListBloc = context.read<StoryListBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            RefreshIndicator(
              displacement: 60,
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                storyListBloc.add(StoryListReload());
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(
                    top: 72, bottom: 16, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScreenTypeLayout.builder(mobile: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Head sentence
                          const HeadSentence(
                            listText: ["Library of", "Infinite Adventures"],
                          ),

                          /// Sub sentence
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 26),
                            child: Text(
                              "SubSentenceInStoryList".i18n,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                      color:
                                          context.theme.colorScheme.onSurface),
                            ),
                          ),

                          /// Function button
                          Row(
                            children: [
                              CircleButtonBar(
                                children: [
                                  CircleButton(
                                      icon: const Icon(Icons.bookmark_border),
                                      onTap: () {
                                        context.pushNamed(
                                            'reading-chamber-bookmark');
                                      }),
                                  CircleButton(
                                      icon: const Icon(Icons.history),
                                      onTap: () {
                                        context.pushNamed(
                                            'reading-chamber-history');
                                      }),
                                ],
                              ),
                              const Spacer(),
                              FilledButton.tonalIcon(
                                  onPressed: () {
                                    storyListBloc.add(StoryListReload());
                                  },
                                  icon:
                                      const Icon(Icons.auto_fix_high_outlined),
                                  label: Text('Suggestion'.i18n)),
                            ],
                          ),
                        ],
                      );
                    }, tablet: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Sub sentence
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 26),
                            child: Text(
                              "SubSentenceInStoryList".i18n,
                              style: context.theme.textTheme.bodyMedium
                                  ?.copyWith(
                                      color:
                                          context.theme.colorScheme.onSurface),
                            ),
                          ),

                          /// Suggestion story button
                          FilledButton.tonalIcon(
                              onPressed: () {
                                storyListBloc.add(StoryListReload());
                              },
                              icon: const Icon(Icons.auto_fix_high_outlined),
                              label: Text('Suggestion'.i18n)),
                        ],
                      );
                    }),

                    /// List article
                    BlocBuilder<StoryListBloc, StoryListState>(
                      bloc: storyListBloc,
                      builder: (context, state) {
                        switch (state) {
                          case StoryListUpdatedState _:
                            return Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  child: LayoutBuilder(
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
                                      cacheExtent: 500,
                                      findChildIndexCallback: (Key key) {
                                        var valueKey = key as ValueKey;
                                        var index = state.articleList
                                            .indexWhere((element) =>
                                                element == valueKey.value);
                                        if (index == -1) return null;
                                        return index;
                                      },
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: 9, //data.articleList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8,
                                        crossAxisCount: crossAxisCount,
                                        mainAxisExtent: 125,
                                        childAspectRatio: 7 /
                                            3, // Adjust the aspect ratio as needed
                                      ),
                                      itemBuilder: (context, index) {
                                        return ReadingTile(
                                          key: ValueKey(
                                              state.articleList[index]),
                                          tag:
                                              "fromStoryListToPage${state.articleList[index].title}Tag",
                                          story: state.articleList[index],
                                          onTap: () {
                                            context.pushNamed(
                                                RouterConstants.readingSpace,
                                                extra:
                                                    state.articleList[index]);
                                          },
                                        );
                                      },
                                    );
                                  }),
                                ),

                                /// Go to search
                                Center(
                                  child: GetMoreButton(
                                    onTap: () {
                                      context.pushNamed(RouterConstants.readingChamberAllList);
                                    },
                                  ),
                                )
                              ],
                            );
                          case StoryListErrorState _:
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const VerticalSpacing.medium(),
                                  ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                        context.theme.colorScheme.primary,
                                        BlendMode.srcIn),
                                    child: Image(
                                      image: AssetImage(
                                          LocalDirectory.commonIllustration),
                                      width: 200,
                                    ),
                                  ),
                                  const VerticalSpacing.medium(),
                                  Text(
                                    "I'm tired. I guess I'm getting old.".i18n,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                  const VerticalSpacing.medium(),
                                  Opacity(
                                    opacity: 0.5,
                                    child: SizedBox(
                                      width: 300,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "Don't worry, this sometimes happens to prove the theory that nothing is perfect. We are on the way to fixing it. So, keep calm and keep kicking."
                                            .i18n,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  const VerticalSpacing.medium(),
                                ],
                              ),
                            );
                          default:
                            storyListBloc.add(StoryListInitial());
                            return const Padding(
                              padding: EdgeInsets.only(top: 50),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                  ],
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            ScreenTypeLayout.builder(mobile: (context) {
              return Header(
                actions: [
                  IconButton(
                      onPressed: () => showSearchPage(context),
                      icon: const Icon(Icons.search)),
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
                            storyListBloc.add(StoryListSortElementary()),
                      ),
                      PopupMenuItem(
                        child: Text("Intermediate".i18n),
                        onTap: () =>
                            storyListBloc.add(StoryListSortIntermediate()),
                      ),
                      PopupMenuItem(
                        child: Text("Advanced".i18n),
                        onTap: () => storyListBloc.add(StoryListSortAdvanced()),
                      ),
                      const PopupMenuItem(
                        enabled: false,
                        height: 0,
                        child: WaveDivider(
                          thickness: .3,
                        ),
                      ),
                      PopupMenuItem(
                        child: Text("All".i18n),
                        onTap: () => storyListBloc.add(StoryListSortAll()),
                      ),
                    ],
                  ),
                ],
              );
            }, tablet: (context) {
              return Header(
                title: 'Library'.i18n,
                enableBackButton: false,
                actions: [
                  IconButton(
                      onPressed: () => showSearchPage(context),
                      icon: const Icon(Icons.search)),
                  const VerticalDivider(),
                  IconButton(
                      icon: const Icon(Icons.bookmark_border),
                      onPressed: () {
                        context.pushNamed('reading-chamber-bookmark');
                      }),
                  IconButton(
                      icon: const Icon(Icons.history),
                      onPressed: () {
                        context.pushNamed('reading-chamber-history');
                      }),
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
                            storyListBloc.add(StoryListSortElementary()),
                      ),
                      PopupMenuItem(
                        child: Text("Intermediate".i18n),
                        onTap: () =>
                            storyListBloc.add(StoryListSortIntermediate()),
                      ),
                      PopupMenuItem(
                        child: Text("Advanced".i18n),
                        onTap: () => storyListBloc.add(StoryListSortAdvanced()),
                      ),
                      const PopupMenuItem(
                        enabled: false,
                        height: 0,
                        child: WaveDivider(
                          thickness: .3,
                        ),
                      ),
                      PopupMenuItem(
                        child: Text("All".i18n),
                        onTap: () => storyListBloc.add(StoryListSortAll()),
                      ),
                    ],
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> showSearchPage(BuildContext context) async {
    showSearch(
      context: context,
      delegate: SearchPage<Story>(
        items: context.read<StoryListBloc>().state.articleList,
        searchLabel: 'Find your story'.i18n,
        searchStyle: context.theme.textTheme.titleMedium,
        suggestion: const Center(child: SearchStoryWelcome()),
        failure: Center(
          child: Text('No matching story found'.i18n),
        ),
        filter: (story) => [story.title, story.content],
        builder: (story) => ListTile(
          title: Text(story.title),
          titleTextStyle: context.theme.textTheme.titleMedium,
          subtitle: Opacity(opacity: .5, child: Text(story.shortDescription)),
          subtitleTextStyle: context.theme.textTheme.bodyMedium,
          onTap: () {
            context.pushNamed(RouterConstants.readingSpace, extra: story);
          },
        ),
      ),
    );
  }
}
