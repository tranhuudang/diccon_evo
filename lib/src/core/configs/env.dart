import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'openai_api.env')
abstract class Env {
  @EnviedField(varName: 'OPENAI_API_KEY', obfuscate: true)
  static final String openaiApiKey = _Env.openaiApiKey;

  @EnviedField(varName: 'OPENAI_API_KEY_BACKUP', obfuscate: true)
  static final String openaiApiKeyBackup = _Env.openaiApiKeyBackup;

  @EnviedField(varName: 'PIXABAY_API_KEY', obfuscate: true)
  static final String pixabayApiKey = _Env.pixabayApiKey;
}