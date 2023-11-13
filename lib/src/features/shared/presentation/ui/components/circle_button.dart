import 'dart:async';
import 'package:diccon_evo/src/common/common.dart';
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
        color: context.theme.colorScheme.surfaceVariant.withOpacity(.3),
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
  final _hoveringController = StreamController<bool>();
  @override
  void dispose() {
    super.dispose();
    _hoveringController.close();
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor =
        context.theme.colorScheme.surfaceVariant;
    return StreamBuilder<bool>(
        stream: _hoveringController.stream,
        initialData: false,
        builder: (context, isHovering) {
          return InkWell(
            onTap: widget.onTap,
            onHover: (isHover) {
              _hoveringController.add(isHover);
            },
            borderRadius: BorderRadius.circular(50),
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: isHovering.data!
                    ? widget.backgroundColor?.withOpacity(.3) ??
                        defaultBackgroundColor.withOpacity(.3)
                    : widget.backgroundColor ?? defaultBackgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(widget.iconData),
            ),
          );
        });
  }
}
