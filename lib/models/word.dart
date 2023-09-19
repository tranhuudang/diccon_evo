class Word {
  final String word;
  final String? pronunciation;
  final String? meaning;
  Word({
    required this.word,
    this.pronunciation,
    this.meaning,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    final word = json['word'].toString().trim();
    final pronunciation = json['pronunciation'].toString().trim();
    final meaning = json['meaning'].toString().trim();
    return Word(
      word: word,
      pronunciation: pronunciation,
      meaning: meaning,
    );
  }

  Map<String, dynamic> toJson() {
    final truncatedMeaning = meaning?.substring(0, 60);
    return {
      'word': word,
      'pronunciation': pronunciation,
      'meaning': truncatedMeaning,
    };
  }
}
