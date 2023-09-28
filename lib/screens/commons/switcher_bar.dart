import 'dart:async';

import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class SwitchBar extends StatefulWidget {
  final SwitchButton firstSelection;
  final SwitchButton secondSelection;
  final Color selectedColor;
  const SwitchBar({
    super.key,
    required this.firstSelection,
    required this.secondSelection,
    required this.selectedColor,
  });

  @override
  State<SwitchBar> createState() => _SwitchBarState();
}

class _SwitchBarState extends State<SwitchBar> {
  final streamController = StreamController<int>();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        initialData: 0,
        stream: streamController.stream,
        builder: (context, snapshot) {
          if (snapshot.data == 0) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  SwitchButton(
                      title: widget.firstSelection.title,
                      onTap: () {
                        streamController.sink.add(0);

                        widget.firstSelection.onTap!();
                      },
                      icon: widget.firstSelection.icon,
                      backgroundColor: widget.selectedColor),
                  SwitchButton(
                      title: widget.secondSelection.title,
                      onTap: () {
                        streamController.sink.add(1);
                        widget.secondSelection.onTap!();
                      },
                      icon: widget.secondSelection.icon,
                      backgroundColor: null),
                ],
              ),
            );
          } else {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(32),
              ),
              child: Row(
                children: [
                  SwitchButton(
                      title: widget.firstSelection.title,
                      onTap: () {
                        streamController.sink.add(0);

                        widget.firstSelection.onTap!();
                      },
                      icon: widget.firstSelection.icon,
                      backgroundColor: null),
                  SwitchButton(
                      title: widget.secondSelection.title,
                      onTap: () {
                        streamController.sink.add(1);
                        widget.secondSelection.onTap!();
                      },
                      icon: widget.secondSelection.icon,
                      backgroundColor: widget.selectedColor),
                ],
              ),
            );
          }
        });
  }
}

class SwitchButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onTap;
  final Icon? icon;
  final Color? backgroundColor;
  const SwitchButton({
    super.key,
    this.title,
    this.onTap,
    this.icon,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: backgroundColor ?? Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              icon ?? const SizedBox.shrink(),
              icon != null
                  ? const SizedBox().smallWidth()
                  : const SizedBox.shrink(),
              Text(title ?? ""),
            ],
          )),
    );
  }
}
