import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../config/local_traditions.dart';

class PillButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String title;
  final bool? isDisabled;
  final Color? backgroundColor;

  const PillButton({super.key, required this.onTap, required this.title, this.icon, this.isDisabled = false, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled! ? null : onTap,
      child: Container(
          padding: Tradition.buttonEdgeInsets,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: isDisabled! ? Theme.of(context).highlightColor: backgroundColor ?? Theme.of(context).primaryColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!= null ?
              Icon(icon, size: 18,) : const SizedBox.shrink(),
              icon!= null ? Tradition.widthSpacer : const SizedBox.shrink(),
              Text(title.i18n),
            ],
          )),
    );
  }
}
