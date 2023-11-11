import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import '../models/text_recognizer_bloc_params.dart';

/// States
abstract class TextRecognizerState {
  TextRecognizerParams params;
  TextRecognizerState({required this.params});
}

class TextRecognizerInitialState extends TextRecognizerState {
  TextRecognizerInitialState({required super.params});
}

class TextRecognizerUpdatedState extends TextRecognizerState {
  TextRecognizerUpdatedState({required super.params});
}

/// Events
abstract class TextRecognizerEvent {}

class AddImageToRecognizer extends TextRecognizerEvent {
  ImageSource imageSource;
  AddImageToRecognizer({required this.imageSource});
}

class TranslateFromGoogle extends TextRecognizerEvent {}

/// Bloc
class TextRecognizerBloc
    extends Bloc<TextRecognizerEvent, TextRecognizerState> {
  TextRecognizerBloc()
      : super(
            TextRecognizerInitialState(params: TextRecognizerParams.init())) {
    on<AddImageToRecognizer>(_addImageToRecognizer);
    on<TranslateFromGoogle>(_translateFromGoogle);
  }

  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  ImagePicker? _imagePicker;
  bool _isBusy = false;
  final GoogleTranslator _googleTranslator = GoogleTranslator();

  FutureOr<void> _addImageToRecognizer(
      AddImageToRecognizer event, Emitter<TextRecognizerState> emit) async {
    InputImage? inputImage = await _getImage(event.imageSource);
    String recognizedContent = '';
    if (inputImage != null) {
      emit(TextRecognizerUpdatedState(
          params: state.params.copyWith(filePath: inputImage.filePath!)));
      recognizedContent = await _processStaticImage(inputImage);
      emit(TextRecognizerUpdatedState(
          params: state.params.copyWith(rawContent: recognizedContent)));
    }
  }

  FutureOr<void> _translateFromGoogle(
      TranslateFromGoogle event, Emitter<TextRecognizerState> emit) async {
    emit(TextRecognizerUpdatedState(
        params: state.params.copyWith(isGoogleTranslating: true)));
    Translation translatedContent = await _googleTranslator
        .translate(state.params.rawContent, from: 'en', to: 'vi');
    emit(TextRecognizerUpdatedState(
        params: state.params.copyWith(
            googleTranslatedContent: translatedContent.text,
            isGoogleTranslating: false)));
  }

  Future<InputImage?> _getImage(ImageSource source) async {
    _imagePicker = ImagePicker();
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      return InputImage.fromFilePath(pickedFile.path);
    }
    return null;
  }

  Future<String> _processStaticImage(InputImage inputImage) async {
    if (_isBusy) return '';
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    _isBusy = false;
    return recognizedText.text;
  }
}
