import 'package:freezed_annotation/freezed_annotation.dart';

part 'word.freezed.dart';
@freezed
class Word with _$Word{
  const factory Word({
  required String word,
   String? pronunciation,
   String? definition,
  }) = _Word;

  factory Word.empty(){
    return const Word(word: '', pronunciation: '', definition: '');
  }
}
