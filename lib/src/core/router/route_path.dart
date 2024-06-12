class RoutePath {
  static const String dictionary = '/dictionary';
  static const String readingChamber = '/reading-chamber';
  static const String dialogue = '/dialogue';
  static const String chatbot = '/chatbot';
  static const String essential = '/essential-1848';

  /// Return corresponding [String] value of [RoutePath] base on index.
  static String fromIndex(int index) {
    switch (index) {
      case 0:
        return dictionary;
      case 1:
        return readingChamber;
      case 2:
        return dialogue;
      case 3:
        return chatbot;
      case 4:
        return essential;
      default:
        return readingChamber;
    }
  }
}
