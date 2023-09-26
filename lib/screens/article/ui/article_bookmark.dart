import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/header.dart';
import '../blocs/article_bookmark_list_bloc.dart';
import 'components/reading_tile.dart';


class ArticleListBookmarkView extends StatefulWidget {
  const ArticleListBookmarkView({super.key});

  @override
  State<ArticleListBookmarkView> createState() => _ArticleListBookmarkViewState();
}

class _ArticleListBookmarkViewState extends State<ArticleListBookmarkView> {

  final articleBookmarkBloc = ArticleBookmarkBloc();

  @override
  Widget build(BuildContext context) {
    //final articleBookmarkBloc = context.read<ArticleBookmarkBloc>();
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
              case ArticleBookmarkInitializedState:
                var data = state as ArticleBookmarkInitializedState;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Header(
                        title: "Bookmark",
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
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
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child:
                                    ReadingTile(article: data.articles[index]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              case ArticleBookmarkSortedState:
                var data = state as ArticleBookmarkSortedState;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Header(
                        title: "Bookmark",
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Expanded(
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
                              return Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child:
                                    ReadingTile(article: data.articles[index]),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              case ArticleBookmarkEmptyState:
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Header(
                        title: "Bookmark",
                      ),
                      Expanded(
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
                    ],
                  ),
                );
              case ArticleBookmarkErrorState:
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Header(
                        title: "Bookmark",
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 100,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Error when trying to get Bookmark".i18n,
                              style: TextStyle(
                                  color: Theme.of(context).highlightColor,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              default:
                articleBookmarkBloc.add(ArticleBookmarkLoad());
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: const Column(
                    children: [
                      Header(
                        title: "Bookmark",
                      ),
                      Expanded(
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
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
