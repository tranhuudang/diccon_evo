import '../properties.dart';

class Video {
  late final String title;
  late final String? source;
  late final String videoThumbnail;
  late final String videoUrl;
  late final DateTime? createdDate;
  late final String content;
  late final String? shortDescription;
  late final String? level;
  late final String? collection;
  Video(
      {required this.title,
        required this.shortDescription,
        required this.content,
        required this.videoUrl,
        required this.videoThumbnail,
        this.source,
        this.createdDate,
        this.level,
        this.collection
      });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
        title: json['title'],
        source: json['source'],
        videoThumbnail: json['videoThumbnail'] ?? "",
        videoUrl: json['videoUrl'],
        createdDate: json['createdDate'] != null
            ? DateTime.parse(json['createdDate'])
            : null,
        content: json['content'],
        shortDescription: json['shortDescription'],
        level: json['level'],
        collection: json['collection']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "source": source,
      "videoThumbnail": videoThumbnail,
      "videoUrl": videoUrl,
      "createdDate": createdDate,
      "content": content,
      "shortDescription": shortDescription,
      "level": level,
      "collection": collection
    };
  }
}
