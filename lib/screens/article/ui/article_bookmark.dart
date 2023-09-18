import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/article.dart';
import '../../commons/circle_button.dart';
import '../cubits/article_bookmark_list_cubit.dart';
import 'components/reading_tile.dart';

class ArticleListBookmarkView extends StatelessWidget {
  const ArticleListBookmarkView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleBookmarkListCubit = context.read<ArticleBookmarkListCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ArticleBookmarkListCubit, List<Article>>(
          builder: (context, state) {
            articleBookmarkListCubit.loadArticleBookmark();
            if (state.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ArticleHistoryHeader(
                        articleBookmarkListCubit: articleBookmarkListCubit),
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
                            "Bookmarks is empty".i18n,
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
            } else {
              return Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ArticleHistoryHeader(
                        articleBookmarkListCubit: articleBookmarkListCubit),
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
                            itemCount: state.length,
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
                              return ReadingTile(article: state[index]);
                            },
                          );
                        },
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

class ArticleHistoryHeader extends StatelessWidget {
  const ArticleHistoryHeader({
    super.key,
    required this.articleBookmarkListCubit,
  });

  final ArticleBookmarkListCubit articleBookmarkListCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton(
          iconData: Icons.arrow_back,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        const SizedBox(
          width: 16,
        ),
        const Text("Bookmarks", style: TextStyle(fontSize: 28)),
        const Spacer(),
        IconButton(
            onPressed: () => articleBookmarkListCubit.sortAlphabet(),
            icon: const Icon(Icons.sort_by_alpha)),
        PopupMenuButton(
          //splashRadius: 10.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Theme.of(context).dividerColor),
            borderRadius: BorderRadius.circular(16.0),
          ),
          itemBuilder: (context) => [
            PopupMenuItem(
              child: Text("Elementary".i18n),
              onTap: () => articleBookmarkListCubit.sortElementary(),
            ),
            PopupMenuItem(
              child: Text("Intermediate".i18n),
              onTap: () => articleBookmarkListCubit.sortIntermediate(),
            ),
            PopupMenuItem(
              child: Text("Advanced".i18n),
              onTap: () => articleBookmarkListCubit.sortAdvanced(),
            ),
            const PopupMenuItem(
              enabled: false,
              height: 0,
              child: Divider(),
            ),
            PopupMenuItem(
              child: Text("All".i18n),
              onTap: () => articleBookmarkListCubit.getAll(),
            ),
            const PopupMenuItem(
              enabled: false,
              height: 0,
              child: Divider(),
            ),
            PopupMenuItem(
              child: Text("Reverse List".i18n),
              onTap: () => articleBookmarkListCubit.sortReverse(),
            ),
            PopupMenuItem(
              child: Text("Clear all".i18n),
              onTap: () => articleBookmarkListCubit.clearBookmark(),
            ),
          ],
        ),
      ],
    );
  }
}