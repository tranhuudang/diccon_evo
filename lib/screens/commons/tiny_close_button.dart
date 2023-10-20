import 'package:flutter/material.dart';


class TinyCloseButton extends StatelessWidget {
  final VoidCallback onTap;
  const TinyCloseButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(32),
          ),
          child: const Icon(Icons.close)),
    );
  }
}
