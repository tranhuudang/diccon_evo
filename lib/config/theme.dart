import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../extensions/target_platform.dart';



class DarkColors {
  static const primaryColor = Colors.blue;
  static const splashColor = Color(0x14B7DCFB);
  static const cardColor = Color(0xFF272727);
  static const scaffoldBackgroundColorMobile = Color(0xFF0F1314);
  static const scaffoldBackgroundColorDesktop = Color(0x50302D2B);
  static const labelMedium = Color(0xFFECEDED);
  static final bodySmall = Colors.grey[700];
  static const titleMedium = Color(0xFF90CAF9);
  static const appBarThemeColor = Color(0xFF171A1C);
  static const bottomNavigationBarThemeBackgroundColor = Color(0xFF202020);
  static const bottomNavigationBarThemeUnselectedItemColor = Color(0xFFD1D1D1);
  static const navigationBarThemeIndicatorColor = Color(0xFF90CAF9);
  static const navigationBarThemeBackgroundColor = Color(0x14BCDFFB);
}

class LightColors {
  static const primaryColor = Colors.blue;
  static const splashColor = Color(0x1F0D417C);
  static const cardColor = Color(0x140D417C);
  static const scaffoldBackgroundColor = Color(0xFFF8FAFD);
  static const labelMedium = Color(0xFF090909);
  static final bodySmall = Colors.grey[700];
  static const titleMedium = Color(0xFF1565C0);
  static const appBarThemeColor = Color(0xFFF8FAFD);
  static const bottomNavigationBarThemeBackgroundColor = Color(0xFFFFFFFF);
  static const bottomNavigationBarThemeUnselectedItemColor = Color(0xFF555555);
  static const navigationBarThemeIndicatorColor = Color(0xFF1565C0);
  static const navigationBarThemeBackgroundColor = Color(0x3D1565C0);
  static const appBarThemeTitleTextStyleColor = Color(0xFF1565C0);
  static const popupMenuThemeColor = Color(0xFFF8FAFD);
}

class CustomTheme {
  static ThemeData getLight(context) {
    ThemeData themeData = Theme.of(context);

    return ThemeData.light().copyWith(
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: LightColors.bottomNavigationBarThemeBackgroundColor,
        selectedItemColor: themeData.primaryColor,
        unselectedItemColor:
            LightColors.bottomNavigationBarThemeUnselectedItemColor,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: LightColors.popupMenuThemeColor,
      ),
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      splashColor: LightColors.splashColor,
      cardColor: LightColors.cardColor,
      primaryColor: LightColors.primaryColor,
      scaffoldBackgroundColor: LightColors.scaffoldBackgroundColor,
      primaryTextTheme: TextTheme(
        labelLarge: const TextStyle(
          color: Colors.red,
          fontSize: 40
        ),
          labelMedium: const TextStyle(
            color: LightColors.labelMedium,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: LightColors.bodySmall,
          ),
          titleMedium: const TextStyle(
              color: LightColors.titleMedium,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: LightColors.appBarThemeTitleTextStyleColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          color: LightColors.appBarThemeColor),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: LightColors.navigationBarThemeIndicatorColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: LightColors.navigationBarThemeBackgroundColor,
      ),
    );
  }

  static ThemeData getDark(context) {
    ThemeData themeData = Theme.of(context);
    return ThemeData.dark().copyWith(
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: themeData.primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
      splashColor: DarkColors.splashColor,
      cardColor: DarkColors.cardColor,
      primaryColor: DarkColors.primaryColor,
      scaffoldBackgroundColor: defaultTargetPlatform.isMobile()
          ? DarkColors.scaffoldBackgroundColorMobile
          : DarkColors.scaffoldBackgroundColorDesktop,
      primaryTextTheme: TextTheme(
          labelMedium: const TextStyle(
            color: DarkColors.labelMedium,
          ),
          bodySmall: TextStyle(
            fontSize: 14.0,
            color: DarkColors.bodySmall,
          ),
          titleMedium: const TextStyle(
              color: DarkColors.titleMedium,
              fontSize: 14,
              fontWeight: FontWeight.bold)),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          color: themeData.primaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis,
        ),
        color: DarkColors.appBarThemeColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: DarkColors.bottomNavigationBarThemeBackgroundColor,
          selectedItemColor: themeData.primaryColor,
          unselectedItemColor:
              DarkColors.bottomNavigationBarThemeUnselectedItemColor),
      navigationBarTheme: const NavigationBarThemeData(
        indicatorColor: DarkColors.navigationBarThemeIndicatorColor,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        backgroundColor: DarkColors.navigationBarThemeBackgroundColor,
      ),
    );
  }
}
