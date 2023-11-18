part of 'main.dart';

class _Initializer {
  static Future<void> load({FirebaseOptions? firebaseOptions}) async {
    // core
    await _initialFirebase(firebaseOptions);
    await _appCheckActivate();

    // ui
    await Properties.initialize();
    if (Platform.isWindows ||
        Platform.isFuchsia ||
        Platform.isLinux ||
        Platform.isMacOS) {
      await windowManager.ensureInitialized();
      // Initialize FFI
      sqfliteFfiInit();

      // Get setting and set default value for windows size, title
      Size savedWindowsSize = Size(Properties.instance.settings.windowsWidth,
          Properties.instance.settings.windowsHeight);
      WindowManager.instance.setSize(savedWindowsSize);
      WindowManager.instance.setMinimumSize(DefaultSettings.minWindowsSize);
      WindowManager.instance.setMaximumSize(DefaultSettings.maxWindowsSize);
      WindowManager.instance.setTitle(DefaultSettings.appName);
    }
    // database
    await EnglishToVietnameseDictionaryDatabase.initialize();
    await VietnameseToEnglishDictionaryDatabase.initialize();
    databaseFactory = databaseFactoryFfi;
  }

  static Future<void> _initialFirebase(FirebaseOptions? firebaseOptions) async {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: firebaseOptions,
      );
    }
  }

  static Future<void> _appCheckActivate() async {
    if (Platform.isAndroid) {
      await FirebaseAppCheck.instance.activate(
        androidProvider: AndroidProvider.debug,
      );
    }
  }
}
