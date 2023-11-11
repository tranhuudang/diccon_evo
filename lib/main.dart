import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DictionaryDatabase.initialize();
  Properties.getSettings();
  /// Initial Firebase
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    );
    FirebaseFirestore.instance;
    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
    );
  }

  /// Initial for Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform ,
    );
    // Initialize FFI
    sqfliteFfiInit();

    /// register player first
    WindowManager.instance.setSize(Size(Properties.defaultSetting.windowsWidth,
        Properties.defaultSetting.windowsHeight));
    WindowManager.instance.setMinimumSize(PropertiesConstants.minWindowsSize);
    WindowManager.instance.setMaximumSize(PropertiesConstants.maxWindowsSize);
    WindowManager.instance.setTitle(PropertiesConstants.diccon);
  }
  databaseFactory = databaseFactoryFfi;
  runApp(const App());
}
