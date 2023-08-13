import 'package:flutter/material.dart';

import '../../helpers/platform_check.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  const Header(
      {Key? key,
      required this.title,
      this.icon,
      this.subtitle,
      this.actions,
      this.iconButton, this.padding})
      : super(key: key);

  final String title;
  final String? subtitle;
  final IconData? icon;
  final IconButton? iconButton;
  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    AppBarTheme theme = Theme.of(context).appBarTheme;
    return Container(
      height: kToolbarHeight,
      decoration: PlatformCheck.isMobile()
          ?  BoxDecoration(
        color: theme.backgroundColor,

              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                ),
              ),
            )
          : null,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
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
                  width: 0,
                ),
          Expanded(
            flex: 4,
            child: Text(
              title,
              style:  theme.titleTextStyle
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
