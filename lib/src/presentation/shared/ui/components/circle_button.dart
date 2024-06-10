import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

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
        color: context.theme.colorScheme.surfaceContainerHighest.withOpacity(.3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Wrap(
        spacing: 8,
        children: children,
      ),
    );
  }
}

class CircleButton extends StatefulWidget {
  final Icon icon;
  final Color? backgroundColor;
  final VoidCallback onTap;

  const CircleButton({
    super.key,
    required this.icon,
    this.backgroundColor,
    required this.onTap,
  });

  @override
  State<CircleButton> createState() => _CircleButtonState();
}

class _CircleButtonState extends State<CircleButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor =
        context.theme.colorScheme.surfaceContainerHighest;
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
        child: widget.icon,
      ),
    );
  }
}
