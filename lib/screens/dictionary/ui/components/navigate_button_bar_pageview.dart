import 'package:flutter/material.dart';

class NavigateBarForRectangeButton extends StatelessWidget {
  final List<Widget> children;
  const NavigateBarForRectangeButton({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: children,
      ),
    );
  }
}

class RectangleButton extends StatefulWidget {
  final IconData iconData;
  final Color? backgroundColor;
  final VoidCallback onTap;
  const RectangleButton(
      {super.key,
      required this.iconData,
      this.backgroundColor,
      required this.onTap});

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
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
      borderRadius: BorderRadius.circular(5),
      child: Opacity(
        opacity: 0.5,
        child: Container(
          alignment: Alignment.center,
          height: 50,
          width: 30,
          decoration: BoxDecoration(
            color: _isHovering
                ? widget.backgroundColor?.withOpacity(.2) ??
                    defaultBackgroundColor.withOpacity(.2)
                : widget.backgroundColor ?? defaultBackgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(widget.iconData),
        ),
      ),
    );
  }
}
