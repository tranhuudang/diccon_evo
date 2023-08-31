class EssentialWord{
  late String id;
  late String english;
  late String phonetic;
  late String vietnamese;
  EssentialWord({required id, required english, required phonetic, required vietnamese});

  EssentialWord.fromJson(Map<String, dynamic> json){
    id = json['id'].toString();
    english = json['english'].toString();
    phonetic = json['phonetic'].toString();
    vietnamese = json['vietnamese'].toString();
  }
}

// Word.fromJson(Map<String, dynamic> json) {
// word = json['word'].toString().trim();
// pronunciation = json["pronunciation"].toString().trim();
// meaning = json['meaning'].toString().trim();
// }