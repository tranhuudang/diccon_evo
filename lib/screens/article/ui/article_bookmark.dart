import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/header.dart';
import '../blocs/article_bookmark_list_bloc.dart';
import 'components/reading_tile.dart';

class ArticleListBookmarkView extends StatefulWidget {
  const ArticleListBookmarkView({super.key});

  @override
  State<ArticleListBookmarkView> createState() =>
      _ArticleListBookmarkViewState();
}

class _ArticleListBookmarkViewState extends State<ArticleListBookmarkView> {
  final articleBookmarkBloc = ArticleBookmarkBloc();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ArticleBookmarkBloc, ArticleBookmarkState>(
          bloc: articleBookmarkBloc,
          listener: (BuildContext context, ArticleBookmarkState state) {},
          buildWhen: (previous, current) =>
              current is! ArticleBookmarkActionState,
          listenWhen: (previous, current) =>
              current is ArticleBookmarkActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case ArticleBookmarkUpdated:
                var data = state as ArticleBookmarkUpdated;
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
                          itemCount: data.articles.length,
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
                            return ReadingTile(article: data.articles[index]);
                          },
                        );
                      },
                    ),
                    Header(
                      title: "Bookmark".i18n,
                      actions: [
                        IconButton(
                            onPressed: () => articleBookmarkBloc.add(
                                ArticleBookmarkSortAlphabet(
                                    articles: data.articles)),
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
                              onTap: () => articleBookmarkBloc
                                  .add(ArticleBookmarkSortElementary()),
                            ),
                            PopupMenuItem(
                              child: Text("Intermediate".i18n),
                              onTap: () => articleBookmarkBloc
                                  .add(ArticleBookmarkSortIntermediate()),
                            ),
                            PopupMenuItem(
                              child: Text("Advanced".i18n),
                              onTap: () => articleBookmarkBloc
                                  .add(ArticleBookmarkSortAdvanced()),
                            ),
                            const PopupMenuItem(
                              enabled: false,
                              height: 0,
                              child: Divider(),
                            ),
                            PopupMenuItem(
                              child: Text("All".i18n),
                              onTap: () => articleBookmarkBloc
                                  .add(ArticleBookmarkGetAll()),
                            ),
                            const PopupMenuItem(
                              enabled: false,
                              height: 0,
                              child: Divider(),
                            ),
                            PopupMenuItem(
                              child: Text("Reverse List".i18n),
                              onTap: () => articleBookmarkBloc.add(
                                  ArticleBookmarkSortReverse(
                                      articles: data.articles)),
                            ),
                            PopupMenuItem(
                              child: Text("Clear all".i18n),
                              onTap: () => articleBookmarkBloc
                                  .add(ArticleBookmarkClear()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              case ArticleBookmarkEmptyState:
                return Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            color: Theme.of(context).cardColor,
                            size: 100,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Bookmark is empty".i18n,
                            style: TextStyle(
                                color: Theme.of(context).highlightColor,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: "Bookmark".i18n,
                    ),
                  ],
                );
              case ArticleBookmarkErrorState:
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
                                color: Theme.of(context).highlightColor,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Header(
                      title: "Bookmark".i18n,
                    ),
                  ],
                );
              default:
                articleBookmarkBloc.add(ArticleBookmarkLoad());
                return Column(
                  children: [
                    Expanded(
                      child: Header(
                        title: "Bookmark".i18n,
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
