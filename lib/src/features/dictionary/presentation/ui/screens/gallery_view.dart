import 'dart:io';
import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

class GalleryView extends StatefulWidget {
  const GalleryView(
      {super.key,
      this.text,
      required this.onImage,
      required this.onDetectorViewModeChanged});

  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  ImagePicker? _imagePicker;

  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text = widget.text ?? '';
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: [
          _galleryBody(),
          Header(
            actions: [
              if (kDebugMode)
                IconButton(
                    onPressed: () {
                      widget.onDetectorViewModeChanged!();
                    },
                    icon: const Icon(UniconsLine.capture))
            ],
          )
        ],
      )),
    );
  }

  Widget _galleryBody() {
    return ListView(
        padding: const EdgeInsets.only(top: 70),
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: HeadSentence(listText: ['Capture your text']),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              child: Text("SubSentenceInImageRecognizer".i18n)),
          _image != null
              ? SizedBox(
                  height: 400,
                  width: 400,
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.file(_image!),
                    ],
                  ),
                )
              : const Image(
                  image: AssetImage('assets/stickers/learn.png'),
                  height: 200,
                ),
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
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Section(title: 'Recognized Text'.i18n, children: [
                  SelectableText(widget.text ?? ''),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DictionaryView(
                                      word: widget.text,
                                      buildContext: context)));
                        },
                        child: Text("Go to dictionary".i18n)),
                  )
                ]),
              ),
            ),
        ]);
  }

  Future _getImage(ImageSource source) async {
    setState(() {
      _image = null;
    });
    final pickedFile = await _imagePicker?.pickImage(source: source);
    if (pickedFile != null) {
      _processFile(pickedFile.path);
    }
  }

  Future _processFile(String path) async {
    setState(() {
      _image = File(path);
    });
    final inputImage = InputImage.fromFilePath(path);
    widget.onImage(inputImage);
  }
}
