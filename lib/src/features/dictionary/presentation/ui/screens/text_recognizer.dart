import 'dart:io';
import 'package:diccon_evo/src/features/shared/presentation/ui/components/wave_divider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import '../../../../../common/common.dart';
import '../../../../features.dart';

class TextRecognizerView extends StatefulWidget {
  const TextRecognizerView({super.key});

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;
  File? _image;
  ImagePicker? _imagePicker;
  bool _isLoading = false;

  final textController = TextEditingController();
  final GoogleTranslator googleTranslator = GoogleTranslator();
  String _translatedText = '';
  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  void dispose() {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _galleryBody(),
          const Header(),
        ],
      )),
    );
  }

  Widget _galleryBody() {
    return ListView(
        padding: const EdgeInsets.only(top: 70),
        shrinkWrap: true,
        children: [
          /// Head and sub title
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: HeadSentence(listText: ['Capture your text']),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              child: Text("SubSentenceInImageRecognizer".i18n)),

          /// Image preview
          _image != null
              ? SizedBox(
                  height: 400,
                  width: 400,
                  child: Image.file(_image!),
                )
              : const Image(
                  image: AssetImage('assets/stickers/learn.png'),
                  height: 200,
                ),

          /// Take picture button and gallery
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: Text('Take a picture'.i18n),
                ),
                ElevatedButton.icon(
                  onPressed: () => _getImage(ImageSource.gallery),
                  icon: const Icon(Icons.collections_outlined),
                  label: Text('Gallery'.i18n),
                ),
              ],
            ),
          ),

          /// Text Recognized Result
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Section(title: 'Recognized Text'.i18n, children: [
                  Align(
                      alignment:Alignment.centerLeft,
                      child: ChoiceChip(label: Text("Correct Spelling"), selected: false)),
                  SizedBox(height: 16,),
                  ExpandablePageView(
                    children: [
                      SelectableText(_text ?? ''),
                      SelectableText(_text ?? ''),
                    ],
                  ),
                  WaveDivider(),
                  if (_isLoading) const LinearProgressIndicator(),
                  SelectableText(_translatedText),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: FilledButton.icon(
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              Translation translation = await googleTranslator
                                  .translate(_text ?? '', from: 'en', to: 'vi');
                              setState(() {
                                _isLoading = false;
                                _translatedText = translation.text;
                              });
                            },
                            icon: const Icon(Icons.translate),
                            label: Text("Translate now".i18n)),
                      ),
                    ],
                  )
                ]),
              ),
            ),
        ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _translatedText = '';
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _translatedText = '';
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    _processStaticImage(inputImage);
  }

  Future<void> _processStaticImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    final recognizedText = await _textRecognizer.processImage(inputImage);
    _isBusy = false;
    setState(() {
      _text = recognizedText.text;
    });
  }
}


