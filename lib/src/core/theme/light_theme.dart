import 'dart:io';

import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme({required ColorScheme colorScheme}) {
  const backgroundColor = Color(0xfffffef5);
  return ThemeData(
    scaffoldBackgroundColor: Platform.isWindows ? colorScheme.surface : backgroundColor,
    cardTheme: CardTheme(
      color: Platform.isWindows ? colorScheme.surface : backgroundColor,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Platform.isWindows ? colorScheme.surface : backgroundColor,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
