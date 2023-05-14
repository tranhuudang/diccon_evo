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
    WindowManager.instance.setMinimumSize(const Size(400, 514));
    WindowManager.instance.setTitle(Global.DICCON_DICTIONARY);
  }
  runApp( MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData.light().copyWith(
        // Customize light theme properties
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.blue, // Light mode background color
          selectedItemColor: Colors.black, // Light mode selected item color
          unselectedItemColor: Colors.grey, // Light mode unselected item color
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        // Customize dark theme properties
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.grey[900], // Dark mode background color
          selectedItemColor: Colors.white, // Dark mode selected item color
          unselectedItemColor: Colors.grey, // Dark mode unselected item color
        ),
      ),
    title: Global.DICCON_DICTIONARY,
      debugShowCheckedModeBanner: false,
      home: HomeView()));
}
