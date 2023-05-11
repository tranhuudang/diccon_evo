import 'package:flutter/material.dart';

class NavigationItem extends StatefulWidget {
   const NavigationItem(
      {Key? key,
      required this.title,
      required this.icon,
      this.onPressed,
      this.isExpanded = false})
      : super(key: key);
  final String title;
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      child: InkWell(
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        onTap: widget.onPressed,
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: isHover ? Colors.blue : Colors.black,
            ),
            widget.isExpanded!
                ? const SizedBox(
                    width: 8,
                  )
                : const SizedBox.shrink(),
            widget.isExpanded! ? Text(widget.title) : Container(),
          ],
        ),
      ),
    );
  }
}
