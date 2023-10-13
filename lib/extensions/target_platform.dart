import 'package:flutter/material.dart';

extension PlatformExtension on TargetPlatform {
  // Using defaultTargetPlatform.isMobile() to check current Platform is Mobile or not
  bool isMobile() {
    return this == TargetPlatform.iOS ||
        this == TargetPlatform.android ||
        this == TargetPlatform.fuchsia;
  }

  bool isAndroid() {
    return this == TargetPlatform.android;
  }

  bool isIOS() {
    return this == TargetPlatform.iOS;
  }

  bool isFushia() {
    return this == TargetPlatform.fuchsia;
  }

  bool isDesktop() {
    return this == TargetPlatform.linux ||
        this == TargetPlatform.macOS ||
        this == TargetPlatform.windows;
  }

  bool isLinux() {
    return this == TargetPlatform.linux;
  }

  bool isWindows() {
    return this == TargetPlatform.windows;
  }

  bool isMacOS() {
    return this == TargetPlatform.macOS;
  }
}
