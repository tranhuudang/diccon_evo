import 'package:flutter/foundation.dart' show kDebugMode;

class DebugLog {
  static void info(String message) {
    _printLog(message, type: 'info');
  }

  static void error(String message) {
    _printLog(message, type: 'error', color: '\x1B[31m'); // ANSI escape code for red color
  }

  static void _printLog(String message, {String type = 'info', String color = ''}) {
    if (kDebugMode) {
      String logType = type.toUpperCase();
      print('$color[DICCON $logType] $message\x1B[0m'); // Reset color with ANSI escape code
    }
  }
}