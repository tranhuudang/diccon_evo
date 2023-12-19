import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:diccon_evo/src/core/core.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ImageBubble extends StatelessWidget {
  final String imageUrl;
  const ImageBubble({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ResponsiveApp(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: 86.sw,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: context.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
