import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_recognizer_bloc_params.freezed.dart';

@freezed
class TextRecognizerParams with _$TextRecognizerParams {
  const factory TextRecognizerParams(
      {required String filePath,
      required String rawContent,
      required String googleTranslatedContent,
      required bool isGoogleTranslating}) = _TextRecognizerParams;

  factory TextRecognizerParams.init() {
    return const TextRecognizerParams(
      filePath: '',
      rawContent: '',
      googleTranslatedContent: '',
      isGoogleTranslating: false,
    );
  }
}
