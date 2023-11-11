import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/app.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Properties.getSettings();
  /// Initial Firebase

  /// Initial for Windows
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
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
