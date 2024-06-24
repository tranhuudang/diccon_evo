import 'dart:io';

import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme({required ColorScheme colorScheme}) {
  return ThemeData(
    scaffoldBackgroundColor: Platform.isWindows ? colorScheme.surface : Colors.black,
    cardTheme: CardTheme(
      color: Colors.grey.withOpacity(.1),
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor:  Platform.isWindows ? colorScheme.surface : Colors.black,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
