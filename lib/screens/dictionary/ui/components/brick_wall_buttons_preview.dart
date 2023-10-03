import 'package:flutter/material.dart';

class BrickWallButtonsPreview extends StatelessWidget {
  final Function(String) onTap;
  final List<String> stringList;
  final Color borderColor;
  final Color textColor;
  const BrickWallButtonsPreview(
      {super.key,
      required this.stringList,
      this.borderColor = Colors.blue,
      this.textColor = Colors.blue, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 48, top: 8, right: 16, bottom: 8),
          child: Wrap(
            alignment: WrapAlignment.end,
            spacing: 8.0,
            runSpacing: 8.0,
            children: stringList.map((String item) {
              return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: borderColor,
                    ),
                    //color: Colors.blue[400],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextButton(
                    onPressed: onTap(item),
                    child: Text(
                      item,
                      style: TextStyle(color: textColor),
                    ),
                  ));
            }).toList(),
          ),
        ),
      ),
    );
  }
}
