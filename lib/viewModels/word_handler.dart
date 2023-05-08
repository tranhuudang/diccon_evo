
class WordHandler {
  // static String removeSpecialCharacters(String str) {
  //   RegExp regExp = RegExp(r"[^a-zA-Z0-9]+");
  //   return str.replaceAll(regExp, "");
  // }
  static String removeSpecialCharacters(String str) {
    RegExp regExp = RegExp(r"[^\p{L}\p{N}]+", unicode: true);
    return str.replaceAll(regExp, "");
  }

  static int numberOfLine(String str){
    return str.split('\n').length;
  }
}
