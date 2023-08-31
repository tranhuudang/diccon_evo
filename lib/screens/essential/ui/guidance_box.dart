import 'package:flutter/material.dart';
class GuidanceBox extends StatelessWidget {
  const GuidanceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      height: 200,
      child: const Column(
        children: [
          Row(
            children: [
              Icon(Icons.play_arrow),
              Text("Start to learn:"),
            ],
          ),
          Row(
            children: [
              Icon(Icons.play_arrow),
              Text("Review:"),
            ],
          ),
          Row(
            children: [
              Icon(Icons.play_arrow),
              Text("Strengthen:"),
            ],
          ),
        ],
      ),
    );
  }
}
