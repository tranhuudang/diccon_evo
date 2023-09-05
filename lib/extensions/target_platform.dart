import 'package:flutter/material.dart';

extension PlatformExtension on TargetPlatform {
  // Using defaultTargetPlatform.isMobile() to check current Platform is Mobile or not
  bool isMobile() {
    return this == TargetPlatform.iOS ||
        this == TargetPlatform.android ||
        this == TargetPlatform.fuchsia;
  }
}