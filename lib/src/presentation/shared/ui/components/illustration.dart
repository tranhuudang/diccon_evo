import 'package:diccon_evo/src/core/core.dart';
import 'package:flutter/material.dart';

class Illustration extends StatelessWidget {
  final String assetImage;
  const Illustration({
    super.key, required this.assetImage,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
          context.theme.colorScheme.primary,
          BlendMode.srcIn),
      child: Image(
        image: AssetImage(assetImage),
        height: 200,
      ),
    );
  }
}