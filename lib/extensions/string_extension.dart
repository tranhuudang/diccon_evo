extension StringExtenstion on String{
   String removeSpecialCharacters() {
    RegExp regExp = RegExp(r"[^\p{L}\p{N}]+", unicode: true);
    return replaceAll(regExp, "");
  }

  int numberOfLine(){
     return split('\n').length;
  }
}