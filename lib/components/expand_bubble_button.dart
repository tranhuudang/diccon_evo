import 'package:flutter/material.dart';

class ExpandBubbleButton extends StatefulWidget {
  const ExpandBubbleButton({Key? key, required this.onTap}) : super(key: key);

  final Function() onTap;

  @override
  State<ExpandBubbleButton> createState() => _ExpandBubbleButtonState();
}

class _ExpandBubbleButtonState extends State<ExpandBubbleButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(16.0),
          bottomRight: const Radius.circular(16.0),
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
        onPressed: widget.onTap,
        child: Text(
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
