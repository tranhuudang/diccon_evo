import 'dart:io';
class PlatformCheck{
  static bool isMobile(){
    if (Platform.isIOS || Platform.isIOS || Platform.isFuchsia) {
      return true;
    } else {
      return false;
    }
  }
}