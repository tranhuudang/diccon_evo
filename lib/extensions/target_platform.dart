import 'package:flutter/material.dart';
extension PlatformExtension on TargetPlatform {
  bool isMobile() {
    return this == TargetPlatform.iOS ||
        this == TargetPlatform.android ||
        this == TargetPlatform.fuchsia;
  }
}