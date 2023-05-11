import 'dart:io';
import 'package:diccon_evo/home.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import 'global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setSize(const Size(400, 700));
    WindowManager.instance.setMinimumSize(const Size(400, 700));
  }
  runApp(const MaterialApp(
    title: Global.DICCON_DICTIONARY,
      debugShowCheckedModeBanner: false,
      home: HomeView()));
}
