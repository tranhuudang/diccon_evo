extension StringExtenstion on String{
   String removeSpecialCharacters() {
    RegExp regExp = RegExp(r"[^\p{L}\p{N}]+", unicode: true);
    return replaceAll(regExp, "");
  }

  String upperCaseFirstLetter(){
     var output = "${substring(0, 1).toUpperCase()}${substring(1).toLowerCase()}";
     return output;
  }

  /// Get the first word in a String
  String getFirstWord(){
      return  substring(0, !contains(" ") ? length : indexOf(" "));
  }

  int numberOfLine(){
     return split('\n').length;
  }
}