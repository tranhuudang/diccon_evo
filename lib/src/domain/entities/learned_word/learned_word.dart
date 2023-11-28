import 'package:freezed_annotation/freezed_annotation.dart';

part 'learned_word.freezed.dart';
@freezed
class LearnedWord with _$LearnedWord{
  const factory LearnedWord({
    required String english,
    required String phonetic,
    required String vietnamese,
    required int counter,
    required bool isFavourite,
}) = _LearnWord;
}