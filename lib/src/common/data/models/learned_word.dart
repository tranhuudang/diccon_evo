class LearnedWord{
  late String english;
  late String phonetic;
  late String vietnamese;
  late int counter;
  late bool isFavourite;
  LearnedWord({required id, required english, required phonetic, required vietnamese, required counter, required isFavourite});

  LearnedWord.fromJson(Map<String, dynamic> json){
    english = json['english'].toString();
    phonetic = json['phonetic'].toString();
    vietnamese = json['vietnamese'].toString();
    counter = json['counter'];
    isFavourite = json['isFavourite'];
  }
}