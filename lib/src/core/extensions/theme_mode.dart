import 'package:flutter/material.dart';

extension StringToThemeMode on String{
  ThemeMode toThemeMode(){
    switch (this){
      case "ThemeMode.light":
        return ThemeMode.light;
      case "ThemeMode.dark":
        return ThemeMode.dark;
      case "ThemeMode.system":
        return ThemeMode.system;
      default:
        throw ArgumentError("Unsupport themeMode value, can not convert this String to ThemeMode");
    }
  }
}