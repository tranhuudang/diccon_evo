part of 'main.dart';


class _Initializer {
  static Future<void> start() async {
    // core
    await _initialFirebase();
    await _appCheckActivate();

    // ui
    await Properties.initialize();
    if (Platform.isWindows ||
        Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isMacOS) {
      await windowManager.ensureInitialized();

      // Get setting and set default value for windows size, title
      Size savedWindowsSize = Size(Properties.instance.settings.windowsWidth,
          Properties.instance.settings.windowsHeight);
      WindowManager.instance.setSize(savedWindowsSize);
      WindowManager.instance.setMinimumSize(DefaultSettings.minWindowsSize);
      WindowManager.instance.setMaximumSize(DefaultSettings.maxWindowsSize);
      WindowManager.instance.setTitle(DefaultSettings.appName);
    }
    // OpenAI
    OpenAITimer.init();
    await OpenAIKeySelector.init();
    Gemini.init(apiKey: Env.apiGeminiKey ,enableDebugging:  true);
  }
  /// Initialize In-app Purchase
  static Future<void> _initializeInAppPurchase() async{
    if (defaultTargetPlatform == TargetPlatform.android) {
    }
  }


  /// Initialize Firebase for specific platform
  static Future<void> _initialFirebase() async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.android,
      );
    }
    if (Platform.isIOS) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.ios,
      );
    }
    // Windows currently not supported, so we use Android options for windows as
    // a temporary solution to get it working.
    if (Platform.isWindows) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.windows,
      );
    }
  }

  static Future<void> _appCheckActivate() async {
    if (Platform.isAndroid) {
      // await FirebaseAppCheck.instance.activate(
      //   androidProvider: AndroidProvider.debug,
      // );
    }
    if (Platform.isIOS){
       // Currently not implement 
    }
  }
}
