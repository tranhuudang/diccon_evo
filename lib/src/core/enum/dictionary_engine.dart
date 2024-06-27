import 'package:diccon_evo/src/core/core.dart';

enum DictionaryEngine{
  stream,
  timeBomb
}

extension DictionaryEngineExtension on String {
  DictionaryEngine get toDictionaryEngine {
    switch (this) {
      case 'stream':
        return DictionaryEngine.stream;
      case 'timeBomb':
        return DictionaryEngine.timeBomb;
      default:
        return DictionaryEngine.stream;
    }
  }
}
