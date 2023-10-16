import 'package:flutter/material.dart';

class Responsive extends StatefulWidget {
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
  State<Responsive> createState() => _ResponsiveState();
}

class _ResponsiveState extends State<Responsive> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final currentWidth = constraints.maxWidth;
      var smallSize = currentWidth < 800;
      var mediumSize = currentWidth > 800 && currentWidth < 1300;
      var largeSize = currentWidth > 1300;
      if (widget.useDefaultPadding!) {
        // Mobile devices (small screen size)
        if (smallSize) {
          print("In small size device");
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: widget.smallSizeDevice,
          );
        }
        // Tablet devices (medium screen size)
        else if (mediumSize) {
          print("In medium size device");

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(100, 16, 100, 16),
              child: widget.mediumSizeDevice ?? widget.smallSizeDevice,
            ),
          );
        }
        // Desktop device (large screen size)
        else if (largeSize) {
          print("In large size device");

          return Padding(
            padding: const EdgeInsets.fromLTRB(200, 16, 200, 16),
            child: widget.largeSizeDevice ?? widget.smallSizeDevice,
          );
        } else {
          return widget.smallSizeDevice;
        }
      } else {
        // Mobile devices (small screen size)
        if (smallSize) {
          print("In small size device");

          return widget.smallSizeDevice;
        }
        // Tablet devices (medium screen size)
        else if (mediumSize) {
          print("In medium size device");

          return widget.mediumSizeDevice ?? widget.smallSizeDevice;
        }
        // Desktop device (large screen size)
        else if (largeSize) {
          print("In large size device");

          return widget.largeSizeDevice ?? widget.smallSizeDevice;
        } else {
          return widget.smallSizeDevice;
        }
      }
    });
  }
}
