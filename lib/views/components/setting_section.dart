import 'package:flutter/material.dart';

class SettingSection extends StatelessWidget {
  final String? title;
  final List<Widget> children;
  const SettingSection({super.key, this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
