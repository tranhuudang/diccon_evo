class LanguageIdentifier{

  /// Default value for undetermined language
  final String undeterminedLanguageCode = 'en';
  final String vietnameseLanguageCode = 'vi';
  final String englishLanguageCode = 'en';

  /// Take a string and identify language using regular expression.
  ///
  /// Supported languages: English, Vietnamese.
  String identifyLanguage(String text){
    if (_isVietnamese(text)) {
      return vietnameseLanguageCode;
    } else {
      return englishLanguageCode;
    }
  }
  /// Regular expression pattern for Vietnamese characters
  ///
  /// This function can use regular expression pattern to identify whether
  /// the provided [text] is Vietnamese.
  ///
  /// Return true if recognized as Vietnamese language.
  bool _isVietnamese(String text) {
    RegExp vietnamesePattern = RegExp(r'[\u00C0-\u1EF9]+');
    return vietnamesePattern.hasMatch(text);
  }
}