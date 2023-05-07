import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileHandler {
  static Future<bool> downloadFile(String url, String fileName) async {
    try {
      var response = await http.get(Uri.parse(url));
      var filePath = await getLocalFilePath(fileName);
      var file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<String> getLocalFilePath(String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    return filePath;
  }
}
