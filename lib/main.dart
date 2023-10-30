import 'dart:io';
import 'package:diccon_evo/src/common/data/data_providers/dictionary_database.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Properties.getSettings();
  /// Initial Firebase
  if (Platform.isAndroid) {
    await DatabaseHelper.initialize();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  }

  /// Initial for Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();

    /// register player first
    WindowManager.instance.setSize(Size(Properties.defaultSetting.windowsWidth,
        Properties.defaultSetting.windowsHeight));
    WindowManager.instance.setMinimumSize(PropertiesConstants.minWindowsSize);
    WindowManager.instance.setMaximumSize(PropertiesConstants.maxWindowsSize);
    WindowManager.instance.setTitle(PropertiesConstants.diccon);
  }

  runApp(const App());
}
