import '../enums/dictionary_response_type.dart';

class ChatPreview{
  final DictionaryResponseType responseType;
  final String content;
  ChatPreview({required this.responseType, required this.content});
}