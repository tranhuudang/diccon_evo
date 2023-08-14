import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'global.dart';
import 'helpers/platform_check.dart';

class CustomTheme {

  static ThemeData getDark(context) {
    if (kDebugMode) {
      print("Dark Theme Applied");
    }
    ThemeData themeData = Theme.of(context);
    return ThemeData.dark().copyWith(

      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
      splashColor: const Color(0x14B7DCFB),
      cardColor: const Color(0xFF171A1C),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: PlatformCheck.isMobile() ? const Color(0xFF0F1314) : const Color(0x00202020),
      primaryTextTheme: TextTheme(
          labelMedium: const TextStyle(
            color: Color(0xFFECEDED),
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
          titleMedium: TextStyle(
              color: const Color(0xFF90CAF9),
              fontSize: Global.titleTileFontSize,
              fontWeight: FontWeight.bold)),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: themeData.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          color: const Color(0xFF171A1C)),

// Customize dark theme properties
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Color(0xFF90CAF9),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color(0x14BCDFFB),
      ),
    );
  }

  static ThemeData getLight(context) {
    ThemeData themeData = Theme.of(context);
    return ThemeData.light().copyWith(
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xFFF8FAFD),
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
      splashColor: const Color(0x1F0D417C),
      cardColor: const Color(0x140D417C),
      primaryColor: const Color(0xFFF8FAFD),
      scaffoldBackgroundColor: const Color(0xFFF8FAFD),
      primaryTextTheme: TextTheme(
          labelMedium: const TextStyle(
            color: Color(0xFF090909),
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
          titleMedium: TextStyle(
              color: const Color(0xFF1565C0),
              fontSize: Global.titleTileFontSize,
              fontWeight: FontWeight.bold)),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          color: Color(0xFFF8FAFD)),

// Customize dark theme properties
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: Color(0xFF1565C0),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color(0x3D1565C0),
      ),
    );
  }

}