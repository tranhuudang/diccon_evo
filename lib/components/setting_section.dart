import 'package:flutter/material.dart';

import '../global.dart';

class SettingSection extends StatefulWidget {
  final String? title;
  final List<Widget> children;

  const SettingSection({Key? key, this.title, required this.children}) : super(key: key);

  @override
  State<SettingSection> createState() => _SettingSectionState();
}

class _SettingSectionState extends State<SettingSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.title ?? '', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: widget.children,
          ),
        ),
      ],
    );
  }
}