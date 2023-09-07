
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/screens/components/circle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/article.dart';
import '../cubits/article_history_list_cubit.dart';
import 'components/reading_tile.dart';

class ArticleListHistoryView extends StatelessWidget {
  const ArticleListHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final articleHistoryListCubit = context.read<ArticleHistoryListCubit>();
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<ArticleHistoryListCubit, List<Article>>(
          builder: (context, state) {
            if (state.isEmpty) {
              articleHistoryListCubit.loadArticleHistory();
              return  Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ArticleHistoryHeader(articleHistoryListCubit: articleHistoryListCubit),
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
                           style:  TextStyle(color: Theme.of(context).highlightColor, fontSize: 18),
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
                    ArticleHistoryHeader(articleHistoryListCubit: articleHistoryListCubit),
                    const SizedBox(height: 16,),

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
    required this.articleHistoryListCubit,
  });

  final ArticleHistoryListCubit articleHistoryListCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleButton(iconData: Icons.arrow_back, onTap: (){
          Navigator.pop(context);
        },),
        const SizedBox(width: 16,),
        Text("History".i18n, style: const TextStyle(fontSize: 28)),
        const Spacer(),
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
    );
  }
}
