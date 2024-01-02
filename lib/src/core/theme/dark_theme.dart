import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/services.dart';

ThemeData darkTheme({required ColorScheme colorScheme}) {
  return ThemeData(
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      scrolledUnderElevation: 0,
    ),
    useMaterial3: true,
    colorScheme: colorScheme,
  );
}
