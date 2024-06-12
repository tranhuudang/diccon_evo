import 'dart:io';

import 'package:diccon_evo/src/core/utils/md5_generator.dart';
import 'package:diccon_evo/src/data/repositories/text_to_speech_repository.dart';
import 'package:diccon_evo/src/data/services/firebase_storage_service.dart';
import 'package:diccon_evo/src/domain/repositories/solo_conversation_repository.dart';
import 'package:path_provider/path_provider.dart';

class SoloConversationRepositoryImpl implements SoloConversationRepository {
  final _firebaseStorageService = FirebaseStorageService('SoloConversation');
  final TextToSpeechRepository _textToSpeechRepository = TextToSpeechRepository();
  @override
  Future<String> getAudio(String sentence) async {
    final md5FileName = Md5Generator.composeMd5IdForSoloConversationFileName(
        sentence: sentence);
    // Get the cache directory
    final cacheDir = await getTemporaryDirectory();

    // Get the file path
    final localFile = File('${cacheDir.path}/$md5FileName');
    final isLocalFileExists = await localFile.exists();
    // Check if audio file already downloaded to device
    if (isLocalFileExists) {
      return localFile.path;
    } else {
      final isFileExistsOnFirebase =
          await _firebaseStorageService.fileExists(md5FileName);
      if (isFileExistsOnFirebase) {
        return await _firebaseStorageService.downloadAudioFile(md5FileName);
      } else {
        final convertedAudioFilePath =
            await _textToSpeechRepository.convertTextToSpeech(
                fromText: sentence, toFilePath: localFile.path);
        _firebaseStorageService.uploadAudioFile(md5FileName);
        if (convertedAudioFilePath != '') {
          return convertedAudioFilePath;
        } else {
          return '';
        }
      }
    }
  }
}
