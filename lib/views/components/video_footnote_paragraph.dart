import 'package:flutter/material.dart';

class VideoFootNoteParagraph extends StatelessWidget {
  final String text;

  VideoFootNoteParagraph({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _parseParagraph(),
      ),
    );
  }

  List<Widget> _parseParagraph() {
    List<Widget> widgets = [];
    final lines = text.split('\n');
    for (String line in lines) {
      if (line.trim().isEmpty) continue;
      if (line.startsWith('-')) {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              line,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Text(line),
          ),
        );
      }
    }
    return widgets;
  }
}
