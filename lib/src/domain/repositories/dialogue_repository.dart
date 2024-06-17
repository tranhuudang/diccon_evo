import 'package:diccon_evo/src/core/enum/sex.dart';

abstract class DialogueRepository{
  /// Return filePath of audio file
  Future<String> getAudio(String sentence, {Sex sex = Sex.men});
}