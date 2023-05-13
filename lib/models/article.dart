class Article {
  late final String title;
  late final String? source;
  late final DateTime? createdDate;
  late final String content;
  late final String shortDescription;
  Article(
      {required this.title,
      required this.shortDescription,
      required this.content,
      this.source,
      this.createdDate});
}
