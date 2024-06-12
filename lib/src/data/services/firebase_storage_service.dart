import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';

class FirebaseStorageService {
  final String folderPath;

  FirebaseStorageService(this.folderPath);

  // Upload audio file from cache folder to Firebase Storage
  Future<void> uploadAudioFile(String fileName) async {
    try {
      // Get the cache directory
      final cacheDir = await getTemporaryDirectory();

      // Get the file path
      final filePath = '${cacheDir.path}/$fileName';

      // Create a reference to the Firebase Storage
      final storageReference =
          FirebaseStorage.instance.ref().child('$folderPath/$fileName');

      // Upload the file
      final file = File(filePath);
      await storageReference.putFile(file);

      print('File uploaded successfully');
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  /// Download audio file from Firebase Storage to cache folder and return filePath
  Future<String> downloadAudioFile(String fileName) async {
    try {
      // Create a reference to the Firebase Storage
      final storageReference =
          FirebaseStorage.instance.ref().child('$folderPath/$fileName');

      // Get the download URL
      final downloadURL = await storageReference.getDownloadURL();

      // Get the cache directory
      final cacheDir = await getTemporaryDirectory();

      // Create the file path
      final filePath = '${cacheDir.path}/$fileName';

      // Download the file
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(downloadURL));
      final response = await request.close();

      if (response.statusCode == 200) {
        final file = File(filePath);
        await response.pipe(file.openWrite());

        print('File downloaded successfully');
        return filePath;
      } else {
        print('Error downloading file: ${response.statusCode}');
        return '';
      }
    } catch (e) {
      print('Error downloading file: $e');
      return '';
    }
  }

  // Check if audio file exists in Firebase Storage
  Future<bool> fileExists(String fileName) async {
    try {
      // Create a reference to the Firebase Storage
      final storageReference =
          FirebaseStorage.instance.ref().child('$folderPath/$fileName');

      // Attempt to get the download URL
      await storageReference.getDownloadURL();
      return true;
    } catch (e) {
      if (e is FirebaseException && e.code == 'object-not-found') {
        return false;
      } else {
        print('Error checking file existence: $e');
        return false;
      }
    }
  }
}
