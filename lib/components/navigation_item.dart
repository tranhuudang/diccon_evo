import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../viewModels/platform_check.dart';

class NavigationItem extends StatefulWidget {
  const NavigationItem(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPressed,
      this.isExpanded = false})
      : super(key: key);
  final String? title;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool? isExpanded;

  @override
  State<NavigationItem> createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      onHover: (value) {
        setState(() {
          isHover = value;

        });
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isHover ? Colors.black12 : Colors.transparent,
        ),
        duration: const Duration(milliseconds: 200),
        child: Row(
          mainAxisAlignment: widget.isExpanded!
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            Icon(
              size: PlatformCheck.isMobile() ? 24 : 20,
              widget.icon,
              color: isHover ? Colors.blue : Colors.black,
            ),
            widget.isExpanded!
                ? const SizedBox(
                    width: 16,
                  )
                : Container(),
            widget.isExpanded! ? Text(widget.title ?? "") : Container(),
          ],
        ),
      ),
    );
  }
}
