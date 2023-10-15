import 'package:diccon_evo/extensions/edge_insets.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String title;
  final bool? isDisabled;
  final Color? backgroundColor;

  const PillButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.icon,
      this.isDisabled = false,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled! ? null : onTap,
      child: Container(
        padding: EdgeInsets.zero.buttonEdgeInsets(),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: isDisabled!
                ? Theme.of(context).highlightColor
                : backgroundColor ?? Theme.of(context).colorScheme.primary),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Icon(
                icon,
                size: 18,
              ),
            if (icon != null) const SizedBox().mediumWidth(),
            Text(
              title.i18n,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
