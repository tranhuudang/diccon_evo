import 'dart:io';
import 'package:diccon_evo/home.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  if (Platform.isWindows) {
    WindowManager.instance.setSize(const Size(400, 700));
    WindowManager.instance.setMinimumSize(const Size(400, 700));
  }
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView()));
}
