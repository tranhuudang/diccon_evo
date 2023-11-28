import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget smallSizeDevice;
  final Widget? mediumSizeDevice;
  final Widget? largeSizeDevice;
  final bool? useDefaultPadding;
  const Responsive(
      {super.key,
      required this.smallSizeDevice,
      this.mediumSizeDevice,
      this.largeSizeDevice,
      this.useDefaultPadding = true});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final smallSize = width < 800;
    final mediumSize = width > 800 && width < 1300;
    final largeSize = width > 1300;
    if (useDefaultPadding! == false) {
      // Mobile devices (small screen size)
      if (smallSize) {
        if (kDebugMode) {
          print("In small size device");
        }

        return smallSizeDevice;
      }
      // Tablet devices (medium screen size)
      else if (mediumSize) {
        if (kDebugMode) {
          print("In medium size device");
        }

        return mediumSizeDevice ?? smallSizeDevice;
      }
      // Desktop device (large screen size)
      else if (largeSize) {
        if (kDebugMode) {
          print("In large size device");
        }

        return largeSizeDevice ?? smallSizeDevice;
      } else {
        return smallSizeDevice;
      }
    }
    // Mobile devices (small screen size)
    if (smallSize) {
      if (kDebugMode) {
        print("In small size device");
      }
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: smallSizeDevice,
      );
    }
    // Tablet devices (medium screen size)
    else if (mediumSize) {
      if (kDebugMode) {
        print("In medium size device");
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(100, 16, 100, 16),
          child: mediumSizeDevice ?? smallSizeDevice,
        ),
      );
    }
    // Desktop device (large screen size)
    else if (largeSize) {
      if (kDebugMode) {
        print("In large size device");
      }

      return Padding(
        padding: const EdgeInsets.fromLTRB(200, 16, 200, 16),
        child: largeSizeDevice ?? smallSizeDevice,
      );
    } else {
      return smallSizeDevice;
    }
  }
}
