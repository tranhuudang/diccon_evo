import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import '../cubits/article_history_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/article.dart';
import 'components/reading_tile.dart';
import 'components/window_title_bar.dart';

class ArticleListHistoryView extends StatelessWidget {
  const ArticleListHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleHistoryListCubit = context.read<ArticleHistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: const WindowTileBar(),
        body: BlocBuilder<ArticleHistoryListCubit, List<Article>>(
          builder: (context, state) {
            if (state.isEmpty) {
              articleHistoryListCubit.loadArticleHistory();
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(
                children: [
                  Header(
                    title: 'History',
                    iconButton: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    actions: [
                      IconButton(
                          onPressed: () => articleHistoryListCubit.sortAlphabet(),
                          icon: const Icon(Icons.sort_by_alpha)),
                      PopupMenuButton(
                        //splashRadius: 10.0,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Theme.of(context).dividerColor),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text("Elementary"),
                            onTap: () => articleHistoryListCubit.sortElementary(),
                          ),
                          PopupMenuItem(
                            child: const Text("Intermediate"),
                            onTap: () => articleHistoryListCubit.sortIntermediate(),
                          ),
                          PopupMenuItem(
                            child: const Text("Advanced"),
                            onTap: () => articleHistoryListCubit.sortAdvanced(),
                          ),
                          const PopupMenuItem(
                            enabled: false,
                            height: 0,
                            child: Divider(),
                          ),
                          PopupMenuItem(
                            child: const Text("All"),
                            onTap: () => articleHistoryListCubit.getAll(),
                          ),
                          const PopupMenuItem(
                            enabled: false,
                            height: 0,
                            child: Divider(),
                          ),
                          PopupMenuItem(
                            child: const Text("Reverse List"),
                            onTap: () => articleHistoryListCubit.sortReverse(),
                          ),
                          PopupMenuItem(
                            child: const Text("Clear all"),
                            onTap: () => articleHistoryListCubit.clearHistory(),
                          ),
                        ],
                      ),
                    ],
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
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
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
              );
            }
          },
        ),
      ),
    );
  }
}
