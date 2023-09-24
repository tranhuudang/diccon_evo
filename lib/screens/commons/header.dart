import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';
import 'circle_button.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.actions,
    this.title,
  });

  final List<Widget>? actions;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleButton(
            iconData: Icons.arrow_back,
            onTap: () {
              Navigator.pop(context);
            }),
        const SizedBox().mediumWidth(),
        title != null
            ? Text(
                title!,
                style: const TextStyle(fontSize: 28),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          width: 16,
        ),
        const Spacer(),
        actions != null
            ? Row(
                children: actions!,
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
