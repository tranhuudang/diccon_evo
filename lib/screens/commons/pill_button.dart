import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import '../../config/local_traditions.dart';

class PillButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const PillButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: Tradition.buttonEdgeInsets,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).primaryColor),
          child: Text(title.i18n)),
    );
  }
}
