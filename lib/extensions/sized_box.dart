import 'package:flutter/material.dart';

extension SizedBoxExtention on SizedBox{
  SizedBox smallWidth() {
    return const SizedBox(width: 4,);
  }
  SizedBox smallHeight() {
    return const SizedBox(height: 4,);
  }
  SizedBox mediumWidth() {
    return const SizedBox(width: 8,);
  }
  SizedBox mediumHeight() {
    return const SizedBox(height: 8,);
  }
  SizedBox largeWidth() {
    return const SizedBox(width: 16,);
  }
  SizedBox largeHeight() {
    return const SizedBox(height: 16,);
  }
}