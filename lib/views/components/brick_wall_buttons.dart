import 'package:flutter/material.dart';

class BrickWallButtons extends StatefulWidget {
  final List<String> stringList;
  final Function(String) itemOnPressed;
  final Color borderColor;
  final Color textColor;
   const BrickWallButtons(
      {super.key, required this.stringList, required this.itemOnPressed, this.borderColor= Colors.blue, this.textColor= Colors.blue});

  @override
  State<BrickWallButtons> createState() => _BrickWallButtonsState();
}

class _BrickWallButtonsState extends State<BrickWallButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Flexible(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: widget.stringList.map((String item) {
                return Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: widget.borderColor,
                      ),
                      //color: Colors.blue[400],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () {
                        widget.itemOnPressed(item);
                      },
                      child: Text(
                        item,
                        style: TextStyle(color: widget.textColor),
                      ),
                    ));
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
