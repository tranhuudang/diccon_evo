import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:diccon_evo/screens/article/ui/article_history.dart';
import 'package:diccon_evo/screens/commons/header.dart';
import 'package:diccon_evo/screens/commons/pill_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/circle_button.dart';
import '../../commons/head_sentence.dart';
import '../blocs/article_list_bloc.dart';
import 'article_bookmark.dart';
import 'components/reading_tile.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  @override
  Widget build(BuildContext context) {
    final articleListBloc = context.read<ArticleListBloc>();
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
                          child: Text(
                              "Let the magic of words transport you to realms uncharted and dreams unbound."
                                  .i18n),
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
                                                  const ArticleListBookmarkView()));
                                    }),
                                CircleButton(
                                    iconData: Icons.history,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ArticleListHistoryView()));
                                    }),
                              ],
                            ),
                            const Spacer(),

                            /// Reload button to reload list article
                            CircleButton(
                                iconData: Icons.autorenew,
                                onTap: () =>
                                    articleListBloc.add(ArticleListReload())),
                          ],
                        ),
                      ],
                    ),

                    /// List article
                    BlocBuilder<ArticleListBloc, ArticleListState>(
                      bloc: articleListBloc,
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case ArticleListInitializedState:
                            var data = state as ArticleListInitializedState;
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
                                              "fromArticleListToPage${data.articleList[index].title}Tag",
                                          article: data.articleList[index]);
                                    },
                                  );
                                },
                              ),
                            );
                          default:
                            articleListBloc.add(ArticleListInitial());
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
                                          articleListBloc
                                              .add(ArticleListCancelLoad());
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
                          onTap: () =>
                              articleListBloc.add(ArticleListSortElementary()),
                        ),
                        PopupMenuItem(
                          child: Text("Intermediate".i18n),
                          onTap: () => articleListBloc
                              .add(ArticleListSortIntermediate()),
                        ),
                        PopupMenuItem(
                          child: Text("Advanced".i18n),
                          onTap: () =>
                              articleListBloc.add(ArticleListSortAdvanced()),
                        ),
                        const PopupMenuItem(
                          enabled: false,
                          height: 0,
                          child: Divider(),
                        ),
                        PopupMenuItem(
                          child: Text("All".i18n),
                          onTap: () =>
                              articleListBloc.add(ArticleListSortAll()),
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
