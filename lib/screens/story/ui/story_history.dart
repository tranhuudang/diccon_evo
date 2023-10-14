import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../config/route_constants.dart';
import '../../commons/header.dart';
import '../blocs/story_history_list_bloc.dart';
import 'components/reading_tile.dart';

class StoryListHistoryView extends StatefulWidget {
  const StoryListHistoryView({super.key});

  @override
  State<StoryListHistoryView> createState() => _StoryListHistoryViewState();
}

class _StoryListHistoryViewState extends State<StoryListHistoryView> {
  final _storyHistoryBloc = StoryHistoryBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<StoryHistoryBloc, StoryHistoryState>(
          bloc: _storyHistoryBloc,
          listener: (BuildContext context, StoryHistoryState state) {},
          buildWhen: (previous, current) => current is! StoryHistoryActionState,
          listenWhen: (previous, current) => current is StoryHistoryActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case StoryHistoryUpdated:
                var data = state as StoryHistoryUpdated;
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
                              onTap: () {
                                context.pushNamed(RouterConstants.readingSpace,
                                    extra: data.stories[index]);
                              },
                            );
                          },
                        );
                      },
                    ),
                    Header(
                      title: "History".i18n,
                      actions: [
                        IconButton(
                            onPressed: () => _storyHistoryBloc.add(
                                StoryHistorySortAlphabet(
                                    stories: data.stories)),
                            icon: const Icon(Icons.sort_by_alpha)),
                        PopupMenuButton(
                          //splashRadius: 10.0,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).dividerColor),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              child: Text("Elementary".i18n),
                              onTap: () => _storyHistoryBloc
                                  .add(StoryHistorySortElementary()),
                            ),
                            PopupMenuItem(
                              child: Text("Intermediate".i18n),
                              onTap: () => _storyHistoryBloc
                                  .add(StoryHistorySortIntermediate()),
                            ),
                            PopupMenuItem(
                              child: Text("Advanced".i18n),
                              onTap: () => _storyHistoryBloc
                                  .add(StoryHistorySortAdvanced()),
                            ),
                            const PopupMenuItem(
                              enabled: false,
                              height: 0,
                              child: Divider(),
                            ),
                            PopupMenuItem(
                              child: Text("All".i18n),
                              onTap: () =>
                                  _storyHistoryBloc.add(StoryHistoryGetAll()),
                            ),
                            const PopupMenuItem(
                              enabled: false,
                              height: 0,
                              child: Divider(),
                            ),
                            PopupMenuItem(
                              child: Text("Reverse List".i18n),
                              onTap: () => _storyHistoryBloc.add(
                                  StoryHistorySortReverse(
                                      stories: data.stories)),
                            ),
                            PopupMenuItem(
                              child: Text("Clear all".i18n),
                              onTap: () =>
                                  _storyHistoryBloc.add(StoryHistoryClear()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              case StoryHistoryEmptyState:
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/stickers/history.png'),
                            width: 200,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "History is empty".i18n,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          const SizedBox().mediumHeight(),
                          Opacity(
                            opacity: 0.5,
                            child: Text(
                              "SubSentenceInStoryHistory".i18n,
                              style: const TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: "History".i18n,
                    ),
                  ],
                );
              case StoryHistoryErrorState:
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
                            "Error trying to get history.".i18n,
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: "History".i18n,
                    ),
                  ],
                );
              default:
                _storyHistoryBloc.add(StoryHistoryLoad());
                return Column(
                  children: [
                    Expanded(
                      child: Header(
                        title: "History".i18n,
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
