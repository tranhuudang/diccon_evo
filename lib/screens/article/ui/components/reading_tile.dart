import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../config/properties.dart';
import '../../../../helpers/article_handler.dart';
import '../../../../models/article.dart';
import '../../../components/level_icon.dart';
import '../article_page.dart';

class ReadingTile extends StatelessWidget {
  final Article article;
  const ReadingTile({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).primaryTextTheme;
    return GridTile(
      child: InkWell(
        onTap: () {
          // Handle tap on article
          // For example, navigate to article details page
          ArticleHandler.saveReadArticleToHistory(article);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticlePageView(
                article: article,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
            ),
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const LinearProgressIndicator(
                        backgroundColor: Colors.black45,
                        color: Colors.black54,
                      ),
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
                          level: article.level ?? Level.intermediate,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}