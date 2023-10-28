import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
class StoryListBookmarkView extends StatefulWidget {
  const StoryListBookmarkView({super.key});

  @override
  State<StoryListBookmarkView> createState() => _StoryListBookmarkViewState();
}

class _StoryListBookmarkViewState extends State<StoryListBookmarkView> {
  final _storyBookmarkBloc = StoryBookmarkBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: BlocConsumer<StoryBookmarkBloc, StoryBookmarkState>(
          bloc: _storyBookmarkBloc,
          listener: (BuildContext context, StoryBookmarkState state) {},
          buildWhen: (previous, current) =>
              current is! StoryBookmarkActionState,
          listenWhen: (previous, current) =>
              current is StoryBookmarkActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case StoryBookmarkUpdated:
                var data = state as StoryBookmarkUpdated;
                return Stack(
                  children: [
                    LayoutBuilder(
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
                          padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
                          itemCount: data.stories.length,
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
                              story: data.stories[index],
                              onTap: () async {
                                bool? isBookmarkChanged = await context
                                    .pushNamed(RouterConstants.readingSpace,
                                        extra: data.stories[index]);
                                if (isBookmarkChanged != null) {
                                  if (isBookmarkChanged == true) {
                                    _storyBookmarkBloc.add(StoryBookmarkLoad());
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
                    Header(
                      title: "Bookmarks".i18n,
                      actions: [
                        IconButton(
                            onPressed: () => _storyBookmarkBloc.add(
                                StoryBookmarkSortAlphabet(
                                    stories: data.stories)),
                            icon: const Icon(Icons.sort_by_alpha)),
                        PopupMenuButton(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: context.theme.dividerColor),
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
                                      stories: data.stories)),
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
                  ],
                );
              case StoryBookmarkEmptyState:
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/stickers/bookmark.png'),
                            height: 200,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "TitleBookmarkEmptyBox".i18n,
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
                                "SubSentenceInBookmarkEmptyList".i18n,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: "Bookmarks".i18n,
                    ),
                  ],
                );
              case StoryBookmarkErrorState:
                return Stack(
                  children: [
                    Center(
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
                    Header(
                      title: "Bookmarks".i18n,
                    ),
                  ],
                );
              default:
                _storyBookmarkBloc.add(StoryBookmarkLoad());
                return Column(
                  children: [
                    Expanded(
                      child: Header(
                        title: "Bookmarks".i18n,
                      ),
                    ),
                    const Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 50,
                              width: 50,
                              child: CircularProgressIndicator())
                        ],
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
