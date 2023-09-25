import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../commons/header.dart';
import '../blocs/article_history_list_bloc.dart';
import 'components/reading_tile.dart';


class ArticleListHistoryView extends StatefulWidget {
  const ArticleListHistoryView({super.key});

  @override
  State<ArticleListHistoryView> createState() => _ArticleListHistoryViewState();
}

class _ArticleListHistoryViewState extends State<ArticleListHistoryView> {

  final articleHistoryBloc = ArticleHistoryBloc();

  @override
  Widget build(BuildContext context) {
    //final articleHistoryBloc = context.read<ArticleHistoryBloc>();
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<ArticleHistoryBloc, ArticleHistoryState>(
          bloc: articleHistoryBloc,
          listener: (BuildContext context, ArticleHistoryState state) {},
          buildWhen: (previous, current) =>
              current is! ArticleHistoryActionState,
          listenWhen: (previous, current) =>
              current is ArticleHistoryActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case ArticleHistoryInitializedState:
                var data = state as ArticleHistoryInitializedState;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Header(
                        title: "History".i18n,
                        actions: [
                          IconButton(
                              onPressed: () => articleHistoryBloc.add(
                                  ArticleHistorySortAlphabet(
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
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortElementary()),
                              ),
                              PopupMenuItem(
                                child: Text("Intermediate".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortIntermediate()),
                              ),
                              PopupMenuItem(
                                child: Text("Advanced".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortAdvanced()),
                              ),
                              const PopupMenuItem(
                                enabled: false,
                                height: 0,
                                child: Divider(),
                              ),
                              PopupMenuItem(
                                child: Text("All".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistoryGetAll()),
                              ),
                              const PopupMenuItem(
                                enabled: false,
                                height: 0,
                                child: Divider(),
                              ),
                              PopupMenuItem(
                                child: Text("Reverse List".i18n),
                                onTap: () => articleHistoryBloc.add(
                                    ArticleHistorySortReverse(
                                        articles: data.articles)),
                              ),
                              PopupMenuItem(
                                child: Text("Clear all".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistoryClear()),
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
              case ArticleHistorySortedState:
                var data = state as ArticleHistorySortedState;
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: Header(
                        title: "History".i18n,
                        actions: [
                          IconButton(
                              onPressed: () => articleHistoryBloc.add(
                                  ArticleHistorySortAlphabet(
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
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortElementary()),
                              ),
                              PopupMenuItem(
                                child: Text("Intermediate".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortIntermediate()),
                              ),
                              PopupMenuItem(
                                child: Text("Advanced".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistorySortAdvanced()),
                              ),
                              const PopupMenuItem(
                                enabled: false,
                                height: 0,
                                child: Divider(),
                              ),
                              PopupMenuItem(
                                child: Text("All".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistoryGetAll()),
                              ),
                              const PopupMenuItem(
                                enabled: false,
                                height: 0,
                                child: Divider(),
                              ),
                              PopupMenuItem(
                                child: Text("Reverse List".i18n),
                                onTap: () => articleHistoryBloc.add(
                                    ArticleHistorySortReverse(
                                        articles: data.articles)),
                              ),
                              PopupMenuItem(
                                child: Text("Clear all".i18n),
                                onTap: () => articleHistoryBloc
                                    .add(ArticleHistoryClear()),
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
              case ArticleHistoryEmptyState:
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Header(
                        title: "History".i18n,
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
                              "History is empty".i18n,
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
              case ArticleHistoryErrorState:
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Header(
                        title: "History".i18n,
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
                              "Error when trying to get history".i18n,
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
                articleHistoryBloc.add(ArticleHistoryLoad());
                return Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Header(
                        title: "History".i18n,
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
                  ),
                );
            }
          },
        ),
      ),
    );
  }
}
