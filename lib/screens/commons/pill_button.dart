import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../config/local_traditions.dart';

class PillButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback onTap;
  final String title;

  const PillButton({super.key, required this.onTap, required this.title, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: Tradition.buttonEdgeInsets,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).primaryColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon!= null ?
              Icon(icon) : const SizedBox.shrink(),
              icon!= null ? Tradition.widthSpacer : const SizedBox.shrink(),
              Text(title.i18n),
            ],
          )),
    );
  }
}
