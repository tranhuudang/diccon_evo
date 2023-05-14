import 'package:diccon_evo/components/header.dart';
import 'package:flutter/material.dart';

class Article {
  final String title;
  final String imageUrl;

  Article({required this.title, required this.imageUrl});
}

class temple {
  static List<Article> articles = [
    Article(
      title:
          'Câu chuyện về một chàng hề cưỡimmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm ngựa trắng trên đỉnh núi xanh ở nam cực.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1200px-Sunflower_from_Silesia2.jpg',
    ),
    Article(
      title: 'Article 2',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1025px-Cat03.jpg',
    ),
    Article(
      title: 'Article 1',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1200px-Sunflower_from_Silesia2.jpg',
    ),
    Article(
      title: 'Article 2',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1025px-Cat03.jpg',
    ),
    Article(
      title: 'Article 1',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1200px-Sunflower_from_Silesia2.jpg',
    ),
    Article(
      title: 'Article 2',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1025px-Cat03.jpg',
    ),
    Article(
      title: 'Article 1',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Sunflower_from_Silesia2.jpg/1200px-Sunflower_from_Silesia2.jpg',
    ),
    Article(
      title: 'Article 2',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Cat03.jpg/1025px-Cat03.jpg',
    ),
    // Add more articles as needed
  ];
}

class ArticleListView extends StatelessWidget {
  const ArticleListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          const Header(title: 'Reading time', icon: Icons.chrome_reader_mode),
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
            itemCount: temple.articles.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 7 / 3, // Adjust the aspect ratio as needed
            ),
            itemBuilder: (context, index) {
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    // Handle tap on article
                    // For example, navigate to article details page
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              temple.articles[index].imageUrl,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          Flexible(
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Text(
                                temple.articles[index].title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ],
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
