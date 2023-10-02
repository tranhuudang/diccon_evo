import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/story/ui/story_history.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:diccon_evo/screens/commons/pill_button.dart';
import 'package:diccon_evo/screens/story/ui/story_reading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../blocs/story_list_bloc.dart';
import 'story_bookmark.dart';
import 'components/reading_tile.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyListBloc = context.read<StoryListBloc>();
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 90, 16, 16),
                child: Column(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 26),
                          child: Text("SubSentenceInStoryList".i18n),
                        ),

                        /// Function button
                        Row(
                          children: [
                            CircleButtonBar(
                              children: [
                                CircleButton(
                                    iconData: Icons.bookmark_border,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const StoryListBookmarkView()));
                                    }),
                                CircleButton(
                                    iconData: Icons.history,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const StoryListHistoryView()));
                                    }),
                              ],
                            ),
                            const Spacer(),

                            /// Reload button to reload list article
                            CircleButton(
                                iconData: Icons.autorenew,
                                onTap: () =>
                                    storyListBloc.add(StoryListReload())),
                          ],
                        ),
                      ],
                    ),

                    /// List article
                    BlocBuilder<StoryListBloc, StoryListState>(
                      bloc: storyListBloc,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case StoryListUpdatedState:
                            var data = state as StoryListUpdatedState;
                            return Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: data.articleList.length,
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
                                        tag:
                                            "fromStoryListToPage${data.articleList[index].title}Tag",
                                        story: data.articleList[index],
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  StoryReadingView(
                                                story: data.articleList[index],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            );
                          case StoryListErrorState:
                            return Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox().mediumHeight(),
                                  const Image(
                                    image: AssetImage('assets/stickers/error.png'),
                                    width: 200,
                                  ),
                                  const SizedBox().mediumHeight(),
                                  Text(
                                    "I'm tired. I guess I'm getting old.".i18n,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20),
                                  ),
                                  const SizedBox().mediumHeight(),
                                  Opacity(
                                    opacity: 0.5,
                                    child: SizedBox(
                                      width: 300,
                                      child: Text(
                                        textAlign: TextAlign.center,
                                        "Don't worry, this sometimes happens to prove the theory that nothing is perfect. We are on the way to fixing it. So, keep calm and keep kicking.".i18n,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  ),
                                  const SizedBox().mediumHeight(),
                                ],
                              ),
                            );
                          default:
                            storyListBloc.add(StoryListInitial());
                            return Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const CircularProgressIndicator(),
                                    const SizedBox().mediumHeight(),
                                    Text("Getting new stories..".i18n),
                                    const SizedBox().mediumHeight(),
                                    PillButton(
                                        onTap: () {
                                          storyListBloc
                                              .add(StoryListCancelLoad());
                                        },
                                        title: "Cancel".i18n),
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
            Header(
              actions: [
                PopupMenuButton(
                  //splashRadius: 10.0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).dividerColor),
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
                      child: Divider(),
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
}
