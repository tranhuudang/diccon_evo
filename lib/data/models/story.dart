import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String title;
  final String? source;
  final String? imageUrl;
  final DateTime? createdDate;
  final String content;
  final String shortDescription;
  final String? level;
  const Story(
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
