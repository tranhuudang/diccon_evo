import 'package:flutter/material.dart';

class ImageBubble extends StatelessWidget {
  final String imageUrl;
  const ImageBubble({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          const Spacer(),
          Flexible(
            /// Added Flexible widget to able to scale base on form's size
            flex: 5,
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.all(3),
                    height: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.scaleDown,
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
