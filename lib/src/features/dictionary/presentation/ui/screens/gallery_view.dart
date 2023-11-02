import 'dart:io';
import 'package:diccon_evo/src/features/features.dart';
import 'package:google_mlkit_commons/google_mlkit_commons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unicons/unicons.dart';

class GalleryView extends StatefulWidget {
  const GalleryView(
      {super.key,
      required this.title,
      this.text,
      required this.onImage,
      required this.onDetectorViewModeChanged});

  final String title;
  final String? text;
  final Function(InputImage inputImage) onImage;
  final Function()? onDetectorViewModeChanged;

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  File? _image;
  ImagePicker? _imagePicker;

  @override
  void initState() {
    super.initState();
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
              : const Icon(
                  Icons.image,
                  size: 200,
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: const Text('From Gallery'),
                onPressed: () => _getImage(ImageSource.gallery),
              ),
              ElevatedButton(
                child: const Text('Take a picture'),
                onPressed: () => _getImage(ImageSource.camera),
              ),
            ],
          ),

          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TipsBox(
                  title: "Recognized Text",
                  children: [SelectableText(widget.text ?? '')]),
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
