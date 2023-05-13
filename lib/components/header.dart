import 'dart:io';

import 'package:flutter/material.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header({Key? key, required this.title, this.icon, this.subtitle, this.actions})
      : super(key: key);

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: Platform.isAndroid || Platform.isIOS
          ? BoxDecoration(
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
          Platform.isAndroid || Platform.isIOS ? SizedBox(width: 50) : Container(),
          Icon(
            size: 24,
            icon,
            color: Colors.black,
          ),
          SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          Row(children: actions ?? []),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(kToolbarHeight);
  }
}
