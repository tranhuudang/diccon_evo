import 'dart:io';

import 'package:flutter/material.dart';

import '../../helpers/platform_check.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header(
      {Key? key,
      required this.title,
      this.icon,
      this.subtitle,
      this.actions,
      this.iconButton})
      : super(key: key);

  final String title;
  final String? subtitle;
  final IconData? icon;
  final IconButton? iconButton;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      decoration: PlatformCheck.isMobile()
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            )
          : null,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          iconButton ?? Container(),
          icon != null
              ? Icon(
                  size: 24,
                  icon,
                  color: Colors.black,
                )
              : Container(),
          iconButton != null
              ? const SizedBox(
                  width: 8,
                )
              : const SizedBox(
                  width: 16,
                ),
          Expanded(
            flex: 4,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Spacer(),

          Row(children: actions ?? []),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return const Size.fromHeight(kToolbarHeight);
  }
}
