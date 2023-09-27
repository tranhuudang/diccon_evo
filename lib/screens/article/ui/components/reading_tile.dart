import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../data/models/article.dart';
import '../../../../data/models/level.dart';
import '../../../commons/level_icon.dart';
import '../../blocs/article_history_list_bloc.dart';
import '../article_page.dart';

class ReadingTile extends StatelessWidget {
  final String? tag;
  final Article article;
  const ReadingTile({
    super.key,
    required this.article, this.tag,

  });

  @override
  Widget build(BuildContext context) {
    final articleHistoryBloc = ArticleHistoryBloc();
    TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return GridTile(
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: () {
          articleHistoryBloc.add(ArticleHistoryAdd(article: article));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlePageView(
                article: article ,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(32),
          ),
          width: 300,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Hero(
                tag: tag ?? article.title,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: CachedNetworkImage(
                      // placeholder: (context, url) =>
                      //     const LinearProgressIndicator(
                      //   backgroundColor: Colors.black45,
                      //   color: Colors.black54,
                      // ),
                      imageUrl: article.imageUrl ?? '',
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, String exception, dynamic stackTrace) {
                        return Container(
                          width: 100.0,
                          height: 100.0,
                          color: Colors
                              .grey, // Display a placeholder color or image
                          child: const Center(
                            child: Text('No Image'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          maxLines: 2,
                          article.shortDescription,
                          textAlign: TextAlign.justify,
                          style: textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      LevelIcon(
                        level: article.level ?? Level.intermediate.toLevelNameString(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
