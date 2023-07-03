import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../global.dart';
import '../../models/article.dart';
import '../article_page.dart';
import 'level_icon.dart';

class ReadingTile extends StatelessWidget {
  final List<Article> state;
  final int tileIndex;
  const ReadingTile({
    super.key, required this.state, required this.tileIndex,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            // Handle tap on article
            // For example, navigate to article details page
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticlePageView(
                      content: state[tileIndex].content,
                      title: state[tileIndex].title,
                      imageUrl:
                      state[tileIndex].imageUrl ?? "",
                    )));
          },
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16),
              ),
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.circular(13),
                      child: CachedNetworkImage(
                        placeholder: (context, url) =>
                        const LinearProgressIndicator(
                          backgroundColor: Colors.black45,
                          color: Colors.black54,
                        ),
                        imageUrl:
                        state[tileIndex].imageUrl ?? '',
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                        errorWidget: (context,
                            String exception,
                            dynamic stackTrace) {
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
                      child: SingleChildScrollView(
                        physics:
                        const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection:
                              Axis.horizontal,
                              child: Row(
                                children: [
                                  LevelIcon(
                                    level: state[tileIndex]
                                        .level ??
                                        Level.intermediate,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    state[tileIndex].title,
                                    textAlign:
                                    TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight:
                                        FontWeight
                                            .bold),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              state[tileIndex].shortDescription,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.black45),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}