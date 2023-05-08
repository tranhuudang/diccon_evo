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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.blueAccent.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(16.0),
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
