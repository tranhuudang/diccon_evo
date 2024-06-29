import 'package:file_picker/file_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:video_compress/video_compress.dart';

class Compressor {
  static Future<PlatformFile> compressImage(
      {required PlatformFile file, double? quality = 30}) async {
    final response = await FlutterImageCompress.compressWithFile(
      file.path!,
      quality: quality!.truncate(),
    );
    PlatformFile compressedFile = PlatformFile(
      bytes: response,
      name: file.name,
      size: response!.lengthInBytes,
    );
    return compressedFile;
  }

  static Future<PlatformFile> compressVideo(
      {required PlatformFile file,
      VideoQuality? quality = VideoQuality.MediumQuality}) async {
    MediaInfo? compressedVideoMediaInfo =
        await VideoCompress.compressVideo(file.path!, quality: quality!);
    final compressedVideo = PlatformFile(
        name: file.name,
        size: compressedVideoMediaInfo!.filesize!,
        path: compressedVideoMediaInfo.path);
    return compressedVideo;
  }
}
