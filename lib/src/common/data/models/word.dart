import 'package:equatable/equatable.dart';

class Word extends Equatable{
  final String word;
  final String? pronunciation;
  final String? definition;
  const Word({
    required this.word,
    this.pronunciation,
    this.definition,
  });

  factory Word.empty(){
    return const Word(word: '', pronunciation: '', definition: '');
  }

  factory Word.fromJson(Map<String, dynamic> json) {
    final word = json['word'].toString().trim();
    final pronunciation = json['pronunciation'].toString().trim();
    final meaning = json['meaning'].toString().trim();
    return Word(
      word: word,
      pronunciation: pronunciation,
      definition: meaning,
    );
  }

  Map<String, dynamic> toJson() {
    final truncatedMeaning = definition?.substring(0, 60);
    return {
      'word': word,
      'pronunciation': pronunciation,
      'meaning': truncatedMeaning,
    };
  }

  @override
  // TODO: implement props
  List<Object?> get props => [word];
}
