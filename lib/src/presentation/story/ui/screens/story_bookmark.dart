import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
import '../../bloc/story_bookmark_list_bloc.dart';

class StoryListBookmarkView extends StatefulWidget {
  const StoryListBookmarkView({super.key});

  @override
  State<StoryListBookmarkView> createState() => _StoryListBookmarkViewState();
}

class _StoryListBookmarkViewState extends State<StoryListBookmarkView> {
  final _storyBookmarkBloc = StoryBookmarkBloc();

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<StoryBookmarkBloc, StoryBookmarkState>(
          bloc: _storyBookmarkBloc,
          listener: (BuildContext context, StoryBookmarkState state) {},
          buildWhen: (previous, current) =>
              current is! StoryBookmarkActionState,
          listenWhen: (previous, current) =>
              current is StoryBookmarkActionState,
          builder: (context, state) {
            switch (state) {
              case StoryBookmarkUpdated _:
                return Scaffold(
                  appBar: AppBar(
                    title: Text("Bookmarks".i18n,),
                    actions: [
                      IconButton(
                          onPressed: () => _storyBookmarkBloc.add(
                              StoryBookmarkSortAlphabet(
                                  stories: state.stories)),
                          icon: const Icon(Icons.sort_by_alpha)),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: context.theme.dividerColor),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text("Elementary".i18n),
                            onTap: () => _storyBookmarkBloc
                                .add(StoryBookmarkSortElementary()),
                          ),
                          PopupMenuItem(
                            child: Text("Intermediate".i18n),
                            onTap: () => _storyBookmarkBloc
                                .add(StoryBookmarkSortIntermediate()),
                          ),
                          PopupMenuItem(
                            child: Text("Advanced".i18n),
                            onTap: () => _storyBookmarkBloc
                                .add(StoryBookmarkSortAdvanced()),
                          ),
                          const PopupMenuItem(
                            enabled: false,
                            height: 0,
                            child: Divider(),
                          ),
                          PopupMenuItem(
                            child: Text("All".i18n),
                            onTap: () =>
                                _storyBookmarkBloc.add(StoryBookmarkGetAll()),
                          ),
                          const PopupMenuItem(
                            enabled: false,
                            height: 0,
                            child: Divider(),
                          ),
                          PopupMenuItem(
                            child: Text("Reverse List".i18n),
                            onTap: () => _storyBookmarkBloc.add(
                                StoryBookmarkSortReverse(
                                    stories: state.stories)),
                          ),
                          PopupMenuItem(
                            child: Text("Clear all".i18n),
                            onTap: () =>
                                _storyBookmarkBloc.add(StoryBookmarkClear()),
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
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        itemCount: state.stories.length,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCount(
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
                            onTap: () async {
                              bool? isBookmarkChanged = await context
                                  .pushNamed(RouterConstants.readingSpace,
                                      extra: state.stories[index]);
                              if (isBookmarkChanged != null) {
                                if (isBookmarkChanged == true) {
                                  // todo
                                  ///_storyBookmarkBloc.add(StoryBookmarkLoad());
                                  if (kDebugMode) {
                                    print("List Bookmark is reloaded");
                                  }
                                }
                              }
                            },
                          );
                        },
                      );
                    },
                  ),
                );
              case StoryBookmarkEmptyState _:
                return Scaffold(
                  appBar: AppBar(title: Text("Bookmarks".i18n),),
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Illustration(assetImage: LocalDirectory.commonIllustration),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "TitleBookmarkEmptyBox".i18n,
                          style: context.theme.textTheme.titleMedium,
                        ),
                        8.height,
                        Opacity(
                          opacity: 0.5,
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              textAlign: TextAlign.center,
                              "SubSentenceInBookmarkEmptyList".i18n,
                              style: context.theme.textTheme.bodyMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              case StoryBookmarkErrorState _:
                return Scaffold(
                  appBar: AppBar(title: Text("Bookmarks".i18n),),
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
                          "Error trying to get Bookmark.".i18n,
                          style: TextStyle(
                              color: context.theme.highlightColor,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                );
              default:
                _storyBookmarkBloc.add(FetchStoryBookmarkFromFirestore());
                return Scaffold(
                  appBar: AppBar(title: Text("Bookmarks".i18n),),
                  body: const Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator()),
                  ),
                );
            }
          },
        );
  }
}
