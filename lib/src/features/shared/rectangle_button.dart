import 'dart:async';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';


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
  final _hoveringController = StreamController<bool>();
  @override
  void dispose(){
    super.dispose();
    _hoveringController.close();
  }

  @override
  Widget build(BuildContext context) {
    final Color defaultBackgroundColor = context.theme.highlightColor;
    return StreamBuilder<bool>(
      stream: _hoveringController.stream,
      initialData: false,
      builder: (context, isHover) {
        return InkWell(
          onTap: widget.onTap,
          onHover: (isHover) {
            _hoveringController.add(isHover);
          },
          borderRadius: BorderRadius.circular(5),
          child: Opacity(
            opacity: 0.5,
            child: Container(
              alignment: Alignment.center,
              height: 50,
              width: 30,
              decoration: BoxDecoration(
                color: isHover.data!
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
    );
  }
}
