import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../config/responsive.dart';
import '../../../config/route_constants.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../blocs/story_list_bloc.dart';
import 'components/reading_tile.dart';

class StoryListView extends StatelessWidget {
  const StoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    final storyListBloc = context.read<StoryListBloc>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            SingleChildScrollView(
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

  Widget body(
      {required BuildContext context,
      required StoryListBloc storyListBloc,
      required int crossAxisCount}) {
    return Padding(
      padding: const EdgeInsets.only(top: 60),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 26),
                child: Text(
                  "SubSentenceInStoryList".i18n,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface),
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

                  /// Reload button to reload list article
                  CircleButton(
                      iconData: Icons.autorenew,
                      onTap: () => storyListBloc.add(StoryListReload())),
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
                        itemCount: data.articleList.length,
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
                      ));
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
                              "Don't worry, this sometimes happens to prove the theory that nothing is perfect. We are on the way to fixing it. So, keep calm and keep kicking."
                                  .i18n,
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
}
