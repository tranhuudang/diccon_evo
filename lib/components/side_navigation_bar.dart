import 'package:flutter/material.dart';

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
      width: isExpanded ? 250 : 58,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
          )
        ],
        border: Border(
          right: BorderSide(
              color: Colors.black12),
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