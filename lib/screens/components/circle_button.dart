import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CircleButtonBar extends StatelessWidget {
  final List<Widget> children;
  const CircleButtonBar({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
    );
  }
}



class CircleButton extends StatefulWidget {
  final IconData iconData;
  final Color? backgroundColor;
  final VoidCallback onTap;
  const CircleButton(
      {super.key,
      required this.iconData,
      this.backgroundColor,
      required this.onTap});

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor = Theme.of(context).highlightColor;
    return InkWell(
      onTap: widget.onTap,
      onHover: (isHover) {
        setState(() {
          _isHovering = isHover;
        });
      },
      borderRadius: BorderRadius.circular(50),
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: _isHovering
              ? widget.backgroundColor?.withOpacity(.3) ??
                  defaultBackgroundColor.withOpacity(.3)
              : widget.backgroundColor ?? defaultBackgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(widget.iconData),
      ),
    );
  }
}
