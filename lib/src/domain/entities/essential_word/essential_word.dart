import 'package:freezed_annotation/freezed_annotation.dart';

part 'essential_word.freezed.dart';
part 'essential_word.g.dart';
@freezed
class EssentialWord with _$EssentialWord{
  const factory EssentialWord({
    required String english,
    required String phonetic,
    required String vietnamese,
}) = _EssentialWord;
  factory EssentialWord.fromJson(Map<String, dynamic> json)
  => _$EssentialWordFromJson(json);

}
