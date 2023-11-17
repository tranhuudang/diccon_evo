import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';

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
                padding: const EdgeInsets.only(top: 60),
                child: Responsive(
                  smallSizeDevice: body(
                      context: context,
                      storyListBloc: storyListBloc,
                      crossAxisCount: 1),
                  mediumSizeDevice: body(
                      context: context,
                      storyListBloc: storyListBloc,
                      crossAxisCount: 2),
                  largeSizeDevice: body(
                      context: context,
                      storyListBloc: storyListBloc,
                      crossAxisCount: 3),
                ),
              ),
            ),
            Header(
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
                      onTap: () => storyListBloc.add(StoryListSortElementary()),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget body(
      {required BuildContext context,
      required StoryListBloc storyListBloc,
      required int crossAxisCount}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Head sentence
            const HeadSentence(
              listText: ["Library of", "Infinite Adventures"],
            ),

            /// Sub sentence
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
              child: Text(
                "SubSentenceInStoryList".i18n,
                style: context.theme.textTheme.titleMedium
                    ?.copyWith(color: context.theme.colorScheme.onSurface),
              ),
            ),

            /// Function button
            Row(
              children: [
                CircleButtonBar(
                  children: [
                    CircleButton(
                        iconData: Icons.bookmark_border,
                        onTap: () {
                          context.pushNamed('reading-chamber-bookmark');
                        }),
                    CircleButton(
                        iconData: Icons.history,
                        onTap: () {
                          context.pushNamed('reading-chamber-history');
                        }),
                  ],
                ),
                const Spacer(),
                FilledButton.tonalIcon(
                    onPressed: () {
                      storyListBloc.add(StoryListReload());
                    },
                    icon: const Icon(Icons.auto_fix_high_outlined),
                    label: Text('Suggestion'.i18n)),
              ],
            ),
          ],
        ),

        /// List article
        BlocBuilder<StoryListBloc, StoryListState>(
          bloc: storyListBloc,
          builder: (context, state) {
            switch (state.runtimeType) {
              case StoryListUpdatedState :
                var data = state as StoryListUpdatedState;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GridView.builder(
                        cacheExtent: 500,
                        findChildIndexCallback: (Key key) {
                          var valueKey = key as ValueKey;
                          var index = data.articleList.indexWhere(
                              (element) => element == valueKey.value);
                          if (index == -1) return null;
                          return index;
                        },
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: 9, //data.articleList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          crossAxisCount: crossAxisCount,
                          mainAxisExtent: 125,
                          childAspectRatio:
                              7 / 3, // Adjust the aspect ratio as needed
                        ),
                        itemBuilder: (context, index) {
                          return ReadingTile(
                            key: ValueKey(data.articleList[index]),
                            tag:
                                "fromStoryListToPage${data.articleList[index].title}Tag",
                            story: data.articleList[index],
                            onTap: () {
                              context.pushNamed(RouterConstants.readingSpace,
                                  extra: data.articleList[index]);
                            },
                          );
                        },
                      ),
                    ),

                    /// Go to search
                    Center(
                      child: GetMoreButton(
                        onTap: () => showSearchPage(context),
                      ),
                    )
                  ],
                );
              case StoryListErrorState :
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const VerticalSpacing.medium(),
                      const Image(
                        image: AssetImage('assets/stickers/error.png'),
                        width: 200,
                      ),
                      const VerticalSpacing.medium(),
                      Text(
                        "I'm tired. I guess I'm getting old.".i18n,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
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
          subtitle: Opacity(
              opacity: .5,
              child: Text(story.shortDescription)),
          subtitleTextStyle: context.theme.textTheme.bodyMedium,
          onTap: () {
            context.pushNamed(RouterConstants.readingSpace, extra: story);
          },
        ),
      ),
    );
  }
}
