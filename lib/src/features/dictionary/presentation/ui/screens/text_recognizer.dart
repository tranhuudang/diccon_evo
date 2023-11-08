import 'dart:async';
import 'dart:io';
import 'package:chat_gpt_flutter/chat_gpt_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wave_divider/wave_divider.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';
import '../../../../../common/common.dart';
import '../../../../features.dart';
import 'package:flutter/material.dart';

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
  String _correctedString='';
  final pageController = PageController();
  String translateOptions = '';

  final textController = TextEditingController();
  final GoogleTranslator googleTranslator = GoogleTranslator();
  String _translatedText = '';
  String _translatedCorrectedText = '';
  bool isCorrecting = false;
  /// Chat gpt
  ChatGptRepository chatGptRepository = ChatGptRepositoryImplement(
      chatGpt: ChatGpt(apiKey: PropertiesConstants.conversationKey));
  StreamSubscription<StreamCompletionResponse>? _chatStreamSubscription;
  var customQuestion = '';
  Future<ChatCompletionRequest> _getQuestionRequest(String fromString) async {
    customQuestion =
    'Help me correct word in this paragraph, just correct and no explaination: $fromString';
    var request = await chatGptRepository
        .createSingleQuestionRequest(customQuestion);
    return request;
  }
  _chatStreamResponse(ChatCompletionRequest request) async {
    _chatStreamSubscription?.cancel();
    try {
      final stream = await chatGptRepository.chatGpt
          .createChatCompletionStream(request);
      _chatStreamSubscription = stream?.listen(
            (event) => setState(
              () {
            if (event.streamMessageEnd) {
              _chatStreamSubscription?.cancel();
              isCorrecting = false;
            } else {
              return chatGptRepository
                  .singleQuestionAnswer.answer
                  .write(
                event.choices?.first.delta?.content,
              );
            }
          },
        ),
      );
    } catch (error) {
      setState(() {
        chatGptRepository.singleQuestionAnswer.answer
            .write(
            "Error: The Diccon server is currently overloaded due to a high number of concurrent users.");
      });
      if (kDebugMode) {
        print("Error occurred: $error");
      }
    }
  }
  void _getGptResponse() async {
      var request = await _getQuestionRequest(_text!);
      _chatStreamResponse(request);

  }

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
    _correctedString = chatGptRepository.singleQuestionAnswer.answer
        .toString()
        .trim();
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
           ListView(
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
                      alignment: Alignment.centerLeft,
                      child: Wrap(
                        runSpacing: 4,
                        spacing: 8,
                        children: [
                          OutlinedButton(onPressed: (){
                            setState(() {
                              isCorrecting = true;
                            });
                            pageController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);

                          }, child: const Text("Raw")),
                          OutlinedButton.icon(onPressed: (){
                            setState(() {
                              isCorrecting = true;
                            });
                            pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
                            if(chatGptRepository.singleQuestionAnswer.answer.isEmpty) {
                              _getGptResponse();
                            }
                          }, icon: isCorrecting? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator()) : const Icon(Icons.check),
                          label: Text("Correct Spelling".i18n)),
                        ],
                      ),
                    ),
                    ExpandablePageView(
                      controller: pageController,
                      children: [
                        /// RAW result
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            SelectableText(_text ?? ''),
                            const WaveDivider(
                              thickness: .3,
                            ),
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
                                        Translation translation =
                                        await googleTranslator.translate(
                                            _text ?? '',
                                            from: 'en',
                                            to: 'vi');
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
                          ],
                        ),
                        /// GPT corrector result
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SelectableText(_correctedString ?? ''),
                            const WaveDivider(
                              thickness: .3,
                            ),
                            if (_isLoading) const LinearProgressIndicator(),
                            SelectableText(_translatedCorrectedText),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Dịch từ:"),
                                SizedBox(
                                  width: 250,
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        isExpanded: true,
                                        borderRadius: BorderRadius.circular(16),
                                        value: "Tiếng Việt sang Tiếng Anh",
                                        hint: Text('Select a language'.i18n),
                                        onChanged: (String? selectedLanguage) {
                                              translateOptions = selectedLanguage!;
                                        },
                                        items: ["Tiếng Việt sang Tiếng Anh","Tiếng Anh sang Tiếng Việt"]
                                            .map(
                                              (value) => DropdownMenuItem<String>(
                                            alignment: Alignment.center,
                                            value: value,
                                            child: Text(value.i18n.toString()),
                                          ),
                                        )
                                            .toList()),
                                  ),
                                ),
                              ],
                            ),
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
                                        Translation translation;
                                        if (translateOptions == "Tiếng Việt sang Tiếng Anh"){
                                         translation =
                                        await googleTranslator.translate(
                                            _correctedString ?? '',
                                            from: 'vi',
                                            to: 'en');
                                         setState(() {
                                           _isLoading = false;
                                           _translatedCorrectedText = translation.text;
                                         });
                                        } else {
                                           translation =
                                          await googleTranslator.translate(
                                              _correctedString ?? '',
                                              from: 'en',
                                              to: 'vi');
                                           setState(() {
                                             _isLoading = false;
                                             _translatedCorrectedText = translation.text;
                                           });
                                        }

                                      },
                                      icon: const Icon(Icons.translate),
                                      label: Text("Translate now".i18n)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              ),
          ]),
          const Header(),
        ],
      )),
    );
  }


  Future _getImage(ImageSource source) async {
    setState(() {
      _translatedText = '';
      _correctedString = '';
      chatGptRepository.singleQuestionAnswer.answer.clear();
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
      _correctedString = '';
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
