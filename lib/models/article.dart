class Article {
  late final String title;
  late final String? source;
  late final String? imageUrl;
  late final DateTime? createdDate;
  late final String content;
  late final String shortDescription;
  Article(
      {required this.title,
      required this.shortDescription,
      required this.content,
        this.imageUrl,
      this.source,
      this.createdDate});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      source: json['source'],
      imageUrl: json['imageUrl'],
      createdDate: json['createdDate'] != null
          ? DateTime.parse(json['createdDate'])
          : null,
      content: json['content'],
      shortDescription: json['shortDescription'],
    );
  }
}
