
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<Uint8List?> compressImage(
    {required String path, required double quality}) async {
  final response = await FlutterImageCompress.compressWithFile(
    path,
    quality: quality.truncate(),
  );
  return response;
}
