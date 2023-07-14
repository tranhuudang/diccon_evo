import 'package:flutter/material.dart';


class ExpandBubbleButton extends StatelessWidget {
  final Function() onTap;
  const ExpandBubbleButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16.0),
          bottomRight: Radius.circular(16.0),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(1),
          ],
        ),
      ),
      child: TextButton(
        onPressed: onTap,
        child: const Text(
          'Expand More',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
