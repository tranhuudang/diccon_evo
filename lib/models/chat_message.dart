class ChatMessage {
  final String sender;
  final String word;
  final String? pronunciation;
  final String? type;
  final String? meaning;

  ChatMessage({
    required this.sender,
    required this.word,
    this.pronunciation,
    this.type,
    this.meaning,
  });
}