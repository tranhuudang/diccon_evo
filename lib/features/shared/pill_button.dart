import 'package:diccon_evo/common/common.dart';
import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String title;
  final bool? isDisabled;
  final Color? backgroundColor;
  final Color? color;

  const PillButton(
      {super.key,
      required this.onTap,
      required this.title,
      this.icon,
      this.isDisabled = false,
      this.backgroundColor,
      this.color});

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
                color: Theme.of(context).colorScheme.onPrimary,
                icon,
                size: 18,
              ),
            if (icon != null) const SizedBox().mediumWidth(),
            Text(
              title.i18n,
              style: TextStyle(
                  color: color ?? Theme.of(context).colorScheme.onPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
