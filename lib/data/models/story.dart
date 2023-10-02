import 'package:equatable/equatable.dart';

class Story extends Equatable {
  late final String title;
  late final String? source;
  late final String? imageUrl;
  late final DateTime? createdDate;
  late final String content;
  late final String shortDescription;
  late final String? level;
  Story(
      {required this.title,
      required this.shortDescription,
      required this.content,
      this.imageUrl,
      this.source,
      this.createdDate,
      this.level});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        title: json['title'],
        source: json['source'],
        imageUrl: json['imageUrl'],
        createdDate: json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null,
        content: json['content'],
        shortDescription: json['shortDescription'],
        level: json['level']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "source": source,
      "imageUrl": imageUrl,
      "createdDate": createdDate,
      "content": content,
      "shortDescription": shortDescription,
      "level": level,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [title];
}
