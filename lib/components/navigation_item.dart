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
    return AnimatedContainer(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
            color: isHover ? Colors.black12 : Colors.transparent,
      ),
      duration: Duration(milliseconds: 200),
      child: InkWell(
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        onTap: widget.onPressed,
        child: Row(
          mainAxisAlignment:  widget.isExpanded! ? MainAxisAlignment.start: MainAxisAlignment.center,
          children: [
            Icon(
              widget.icon,
              color: isHover ? Colors.blue : Colors.black,
            ),
            widget.isExpanded!
                ? const SizedBox(
                    width: 8,
                  )
                : Container(),
            widget.isExpanded! ? Text(widget.title) : Container(),
          ],
        ),
      ),
    );
  }
}
