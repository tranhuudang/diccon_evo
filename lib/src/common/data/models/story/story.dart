import 'package:diccon_evo/src/common/common.dart';

part 'story.freezed.dart';
part 'story.g.dart';
@freezed
class Story with _$Story {
  const factory Story(
      { required String title,
       String? source,
       String? imageUrl,
       DateTime? createdDate,
      required String content,
      required String shortDescription,
       String? level,}) = _Story;

  factory Story.fromJson(Map<String, dynamic> json)
    => _$StoryFromJson(json);

}
