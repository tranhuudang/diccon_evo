import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/views/components/header.dart';
import 'package:flutter/material.dart';
import '../cubits/article_history_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/article.dart';
import 'components/reading_tile.dart';

class ArticleListHistoryView extends StatelessWidget {
  const ArticleListHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleHistoryListCubit = context.read<ArticleHistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        appBar: Header(
          padding: const EdgeInsets.only(left: 16, right: 0),
          title: 'History'.i18n,
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
                  child:  Text("Elementary".i18n),
                  onTap: () => articleHistoryListCubit.sortElementary(),
                ),
                PopupMenuItem(
                  child:  Text("Intermediate".i18n),
                  onTap: () => articleHistoryListCubit.sortIntermediate(),
                ),
                PopupMenuItem(
                  child:  Text("Advanced".i18n),
                  onTap: () => articleHistoryListCubit.sortAdvanced(),
                ),
                const PopupMenuItem(
                  enabled: false,
                  height: 0,
                  child: Divider(),
                ),
                PopupMenuItem(
                  child:  Text("All".i18n),
                  onTap: () => articleHistoryListCubit.getAll(),
                ),
                const PopupMenuItem(
                  enabled: false,
                  height: 0,
                  child: Divider(),
                ),
                PopupMenuItem(
                  child:  Text("Reverse List".i18n),
                  onTap: () => articleHistoryListCubit.sortReverse(),
                ),
                PopupMenuItem(
                  child:  Text("Clear all".i18n),
                  onTap: () => articleHistoryListCubit.clearHistory(),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ArticleHistoryListCubit, List<Article>>(
          builder: (context, state) {
            if (state.isEmpty) {
              articleHistoryListCubit.loadArticleHistory();
              return  Column(
                children: [

                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Icon(
                            Icons.broken_image,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "History is empty".i18n,
                            style: TextStyle(color: Colors.black45, fontSize: 18),
                          )
                        ]),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
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
                            mainAxisExtent: 150,
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
