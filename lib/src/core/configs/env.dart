import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'openai_api.env')
abstract class Env {
  // dart run build_runner build

  @EnviedField(varName: 'OPENAI_API_KEY', obfuscate: true)
  static final String openaiApiKey = _Env.openaiApiKey;

  @EnviedField(varName: 'PIXABAY_API_KEY', obfuscate: true)
  static final String pixabayApiKey = _Env.pixabayApiKey;

  @EnviedField(varName: 'PREMIUM_TOKEN', obfuscate: true)
  static final String premiumToken = _Env.premiumToken;

  @EnviedField(varName: 'API_MASTER_KEY', obfuscate: true)
  static final String apiMasterKey = _Env.apiMasterKey;

  @EnviedField(varName: 'GEMINI_API_KEY', obfuscate: true)
  static final String apiGeminiKey = _Env.apiGeminiKey;
}