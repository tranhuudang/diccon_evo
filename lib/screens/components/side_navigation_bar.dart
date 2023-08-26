import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../extensions/target_platform.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({
    super.key,
    required this.isExpanded,
    required this.navigationItem,
  });

  final bool isExpanded;
  final List<Widget> navigationItem;

  @override
  Widget build(BuildContext context) {
    BottomNavigationBarThemeData theme =
        Theme.of(context).bottomNavigationBarTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      width: isExpanded
          ? 250
          : defaultTargetPlatform.isMobile()
              ? 60
              : 50,
      decoration: BoxDecoration(
        border: const Border(
          right: BorderSide(color: Colors.black12, width: 0.7),
        ),
        color: theme.backgroundColor,
      ),

      /// List Navigation Item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navigationItem,
      ),
    );
  }
}
