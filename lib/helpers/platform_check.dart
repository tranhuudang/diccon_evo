import 'dart:io';
class PlatformCheck{
  static bool isMobile(){
    if (Platform.isIOS || Platform.isAndroid || Platform.isFuchsia) {
      return true;
    } else {
      return false;
    }
  }
}