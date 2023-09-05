import 'package:flutter/material.dart';

import '../../config/properties.dart';

class LevelIcon extends StatelessWidget {
  final String level;
  const LevelIcon({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: Container(
        height: 16,
        width: 16,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: level == Level.advanced
                ? Colors.black
                : level == Level.intermediate
                    ? Colors.black45
                    : level == Level.elementary
                        ? Colors.orange
                        : Colors.green),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            level.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ),
      ),
    );
  }
}