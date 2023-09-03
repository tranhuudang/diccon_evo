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

  Map<String, dynamic> toJson(){
    return {
      'id' : id,
      'english' : english,
      'phonetic' : phonetic,
      'vietnamese' : vietnamese
    };
  }
}
