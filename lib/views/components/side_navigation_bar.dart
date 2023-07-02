import 'package:flutter/material.dart';

import '../../helpers/platform_check.dart';

class SideNavigationBar extends StatelessWidget {
  const SideNavigationBar({
    super.key,
    required this.isExpanded, required this.navigationItem,
  });

  final bool isExpanded;
  final List<Widget> navigationItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
      width: isExpanded ? 250 : PlatformCheck.isMobile() ? 60 : 50,
      decoration: const BoxDecoration(
        border: Border(
          right: BorderSide(
              color: Colors.black12, width: 0.7),
        ),
        color: Colors.white,
      ),
      /// List Navigation Item
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: navigationItem,
      ),
    );
  }
}