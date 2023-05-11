import 'package:flutter/material.dart';

import '../global.dart';
class HeaderBox extends StatelessWidget {
  const HeaderBox({Key? key, required this.title, this.icon, this.subtitle, this.actions}) : super(key: key);

  final String title;
  final String? subtitle;
  final IconData? icon;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, right: 16, bottom: 10, left: 16),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(

                children:  [
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
              ]
              ),
              Text(subtitle??""),
            ],
          ),
          /// Action button follow behind header's title
          Spacer(),
          Row(children: actions ?? []),
        ],
      ),
    );
  }
}
