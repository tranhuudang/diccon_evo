import 'dart:async';
import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:flutter/material.dart';

class RectangleButton extends StatefulWidget {
  final IconData iconData;
  final Color? backgroundColor;
  final VoidCallback onTap;
  final bool isLeftSided;
  final bool isNormal;
  final bool isRightSided;
  const RectangleButton({
    super.key,
    required this.iconData,
    this.backgroundColor,
    required this.onTap,
  })  : isLeftSided = false,
        isNormal = true,
        isRightSided = false;

  const RectangleButton.leftSided(
      {required this.iconData,
      this.backgroundColor,
      required this.onTap,

      super.key})
      : isNormal = false,
        isRightSided = false,
        isLeftSided = true;
  const RectangleButton.rightSided(
      {required this.iconData,
      this.backgroundColor,
      required this.onTap,

      super.key})
      :
        isLeftSided = false,
        isNormal = false,
        isRightSided = true;

  @override
  State<RectangleButton> createState() => _RectangleButtonState();
}

class _RectangleButtonState extends State<RectangleButton> {
  final _hoveringController = StreamController<bool>();
  @override
  void dispose() {
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
                width: 40,
                decoration: BoxDecoration(
                  color: isHover.data!
                      ? widget.backgroundColor?.withOpacity(.2) ??
                          defaultBackgroundColor.withOpacity(.2)
                      : widget.backgroundColor ?? defaultBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.isLeftSided
                        ? 0
                        : widget.isRightSided
                            ? 50
                            : 5),
                    bottomLeft: Radius.circular(widget.isLeftSided
                        ? 0
                        : widget.isRightSided
                            ? 50
                            : 5),
                    topRight: Radius.circular(widget.isLeftSided
                        ? 50
                        : widget.isRightSided
                            ? 0
                            : 5),
                    bottomRight: Radius.circular(widget.isLeftSided
                        ? 50
                        : widget.isRightSided
                            ? 0
                            : 5),
                  ),
                ),
                child: Icon(widget.iconData),
              ),
            ),
          );
        });
  }
}
