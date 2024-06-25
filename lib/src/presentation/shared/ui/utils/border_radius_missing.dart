import 'package:flutter/material.dart';

class BorderRadiusMissing {
  static const BorderRadius topRight = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(0.0),
    bottomLeft: Radius.circular(16.0),
    bottomRight: Radius.circular(16.0),
  );

  static const BorderRadius topLeft = BorderRadius.only(
    topLeft: Radius.circular(0.0),
    topRight: Radius.circular(16.0),
    bottomLeft: Radius.circular(16.0),
    bottomRight: Radius.circular(16.0),
  );

  static const BorderRadius bottomLeft = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(16.0),
    bottomLeft: Radius.circular(0.0),
    bottomRight: Radius.circular(16.0),
  );

  static const BorderRadius bottomRight = BorderRadius.only(
    topLeft: Radius.circular(16.0),
    topRight: Radius.circular(16.0),
    bottomLeft: Radius.circular(16.0),
    bottomRight: Radius.circular(0.0),
  );
}