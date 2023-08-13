import 'package:flutter/material.dart';

import 'global.dart';

class CustomTheme {

  static ThemeData getDark(context) {
    ThemeData themeData = Theme.of(context);
    return ThemeData.dark().copyWith(
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
      splashColor: Color(0x14B7DCFB),
      cardColor: Color(0xFF171A1C),
      primaryColor: Colors.blue,
      scaffoldBackgroundColor: Color(0xFF0F1314),
      primaryTextTheme: TextTheme(
          labelMedium: TextStyle(
            color: Color(0xFFECEDED),
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
          titleMedium: TextStyle(
              color: Color(0xFF90CAF9),
              fontSize: Global.titleTileFontSize,
              fontWeight: FontWeight.bold)),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: themeData.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          color: Color(0xFF171A1C)),

// Customize dark theme properties
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Color(0xFF90CAF9),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color(0x14BCDFFB),
      ),
    );
  }

  static ThemeData getLight(context) {
    ThemeData themeData = Theme.of(context);
    return ThemeData.light().copyWith(
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16))),
      splashColor: Color(0x1F0D417C),
      cardColor: Color(0x140D417C),
      primaryColor: Color(0xFFF8FAFD),
      scaffoldBackgroundColor: Color(0xFFF8FAFD),
      primaryTextTheme: TextTheme(
          labelMedium: TextStyle(
            color: Color(0xFF090909),
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: Colors.grey[700],
          ),
          titleMedium: TextStyle(
              color: Color(0xFF1565C0),
              fontSize: Global.titleTileFontSize,
              fontWeight: FontWeight.bold)),
      appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          color: Color(0xFFF8FAFD)),

// Customize dark theme properties
      navigationBarTheme: NavigationBarThemeData(
        indicatorColor: Color(0xFF1565C0),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: Color(0x3D1565C0),
      ),
    );
  }

}