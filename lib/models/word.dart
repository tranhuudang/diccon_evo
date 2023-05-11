class Word {
  late final String word;
  late final String? pronunciation;
  late final String? meaning;

  Word({
    required this.word,
    this.pronunciation,
    this.meaning,
  });

  Word.fromJson(Map<String, dynamic> json) {
    word = json['word'].toString().trim();
    pronunciation = json["pronunciation"].toString().trim();
    meaning = json['meaning'].toString().trim();
  }

  Map<String, dynamic> toJson() {
    String? truncatedMeaning = '';
    if (meaning != null) {
      truncatedMeaning =
          meaning!.length > 50 ? meaning!.substring(0, 50) : meaning;
    }
    return {
      'word': word,
      'pronunciation': pronunciation,
      'meaning': truncatedMeaning,
    };
  }


}
