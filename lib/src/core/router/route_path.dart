class RoutePath {
  static const String dictionary = '/dictionary';
  static const String readingChamber = '/reading-chamber';
  static const String soloConversation = '/solo-conversation';
  static const String conversation = '/conversation';
  static const String essential = '/essential-1848';

  /// Return corresponding [String] value of [RoutePath] base on index.
  static String fromIndex(int index) {
    switch (index) {
      case 0:
        return dictionary;
      case 1:
        return readingChamber;
      case 2:
        return soloConversation;
      case 3:
        return conversation;
      case 4:
        return essential;
      default:
        return readingChamber;
    }
  }
}
