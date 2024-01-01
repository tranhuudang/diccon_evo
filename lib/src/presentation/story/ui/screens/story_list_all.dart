import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/domain/domain.dart';
import 'package:search_page/search_page.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import '../../bloc/story_list_all_bloc.dart';

class StoryListAllView extends StatelessWidget {
  const StoryListAllView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyListBloc = context.read<StoryListAllBloc>();
    return Scaffold(
      appBar: AppBar(
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
                    storyListBloc.add(StoryListAllSortElementary()),
              ),
              PopupMenuItem(
                child: Text("Intermediate".i18n),
                onTap: () =>
                    storyListBloc.add(StoryListAllSortIntermediate()),
              ),
              PopupMenuItem(
                child: Text("Advanced".i18n),
                onTap: () => storyListBloc.add(StoryListAllSortAdvanced()),
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
                onTap: () => storyListBloc.add(StoryListAllSortAll()),
              ),
            ],
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          /// List article
          BlocBuilder<StoryListAllBloc, StoryListAllState>(
            bloc: storyListBloc,
            builder: (context, state) {
              switch (state) {
                case StoryListAllUpdatedState _:
                  return LayoutBuilder(
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
                          itemCount: state.articleList.length,
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
                      });
                case StoryListAllErrorState _:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        8.height,
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
                        8.height,
                        Text(
                          "I'm tired. I guess I'm getting old.".i18n,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        8.height,
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
                        8.height,
                      ],
                    ),
                  );
                default:
                  storyListBloc.add(StoryListAllInitial());
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
    );
  }

  Future<void> showSearchPage(BuildContext context) async {
    showSearch(
      context: context,
      delegate: SearchPage<Story>(
        items: context.read<StoryListAllBloc>().state.articleList,
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
