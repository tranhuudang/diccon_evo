import 'package:diccon_evo/views/components/header.dart';
import 'package:diccon_evo/views/article_page.dart';
import 'package:flutter/material.dart';
import '../cubits/article_list_cubit.dart';
import '../global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/article.dart';
import 'components/reading_tile.dart';

class ArticleListView extends StatelessWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: Header(
          title: 'Reading time',
          icon: Icons.chrome_reader_mode,
          actions: [
            PopupMenuButton(
              //splashRadius: 10.0,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(16.0),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: const Text("Elementary"),
                  onTap: () => context.read<ArticleListCubit>().sortElementary(),
                ),
                PopupMenuItem(
                  child: const Text("Intermediate"),
                  onTap: () => context.read<ArticleListCubit>().sortIntermediate(),
                ),
                PopupMenuItem(
                  child: const Text("Advanced"),
                  onTap: () => context.read<ArticleListCubit>().sortAdvanced(),
                ),
                const PopupMenuItem(
                  enabled: false,
                  height: 0,
                  child: Divider(),
                ),
                PopupMenuItem(
                  child: const Text("All"),
                  onTap: () => context.read<ArticleListCubit>().getAll(),
                ),
              ],
            ),
          ],
        ),
        body: BlocBuilder<ArticleListCubit, List<Article>>(
          builder: (context, state) {
            if (state.isEmpty) {
              context.read<ArticleListCubit>().loadUp();
              return const Center(child: CircularProgressIndicator());
            } else {
              return LayoutBuilder(
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
                      return ReadingTile(state: state, tileIndex: index);
                    },
                  );
                },
              );
            }
          },
        ),
    );
  }
}
