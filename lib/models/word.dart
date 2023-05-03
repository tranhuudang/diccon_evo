class Word {
  final String sender;
  final String word;
  final String? pronunciation;
  final String? type;
  final String? meaning;

  Word({
    required this.sender,
    required this.word,
    this.pronunciation,
    this.type,
    this.meaning,
  });
}