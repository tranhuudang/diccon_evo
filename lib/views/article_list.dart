import 'package:diccon_evo/views/components/header.dart';
import 'package:diccon_evo/views/article_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../global.dart';
import '../models/article.dart';

class ArticleListView extends StatefulWidget {
  const ArticleListView({super.key});

  @override
  State<ArticleListView> createState() => _ArticleListViewState();
}

class _ArticleListViewState extends State<ArticleListView> {
  List<Article> _listArticles = [];

  @override
  void initState() {
    super.initState;
    _listArticles = Global.defaultArticleList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // PopupMenuItem(
              //   child: const Text("Beginner"),
              //   onTap: () {
              //     setState(() {
              //       _listArticles = Global.defaultArticleList
              //           .where((element) => element.level == Level.beginner)
              //           .toList();
              //     });
              //   },
              // ),
              PopupMenuItem(
                child: const Text("Elementary"),
                onTap: () {
                  setState(() {
                    _listArticles = [];
                    _listArticles = Global.defaultArticleList
                        .where((element) => element.level == Level.elementary)
                        .toList();
                  });
                },
              ),
              PopupMenuItem(
                child: const Text("Intermediate"),
                onTap: () {
                  setState(() {
                    _listArticles = Global.defaultArticleList
                        .where((element) => element.level == Level.intermediate)
                        .toList();
                  });
                },
              ),
              PopupMenuItem(
                child: const Text("Advanced"),
                onTap: () {
                  setState(() {
                    _listArticles = Global.defaultArticleList
                        .where((element) => element.level == Level.advanced)
                        .toList();
                  });
                },
              ),
              const PopupMenuItem(
                enabled: false,
                height: 0,
                child: Divider(),
              ),
              PopupMenuItem(
                child: const Text("All"),
                onTap: () {
                  setState(() {
                    _listArticles = Global.defaultArticleList;
                  });
                },
              ),
            ],
          ),
        ],
      ),
      body: LayoutBuilder(
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
            itemCount: _listArticles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 7 / 3, // Adjust the aspect ratio as needed
            ),
            itemBuilder: (context, index) {
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
                                    content: _listArticles[index].content,
                                    title: _listArticles[index].title,
                                    imageUrl: Global
                                            .defaultArticleList[index].imageUrl ??
                                        "",
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
                                  imageUrl: _listArticles[index].imageUrl ?? '',
                                  height: 100.0,
                                  width: 100.0,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, String exception,
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
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            LevelIcon(
                                              level: _listArticles[index].level ??
                                                  Level.intermediate,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              _listArticles[index].title,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        _listArticles[index].shortDescription,
                                        textAlign: TextAlign.justify,
                                        style: TextStyle(
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
            },
          );
        },
      ),
    );
  }
}

class LevelIcon extends StatelessWidget {
  final String level;
  const LevelIcon({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: level == Level.advanced
                ? Colors.black
                : level == Level.intermediate
                    ? Colors.black45
                    : level == Level.elementary
                        ? Colors.orange
                        : Colors.green),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              level.substring(0, 1).toUpperCase(),
              style: const TextStyle(color: Colors.white),
            )));
  }
}
