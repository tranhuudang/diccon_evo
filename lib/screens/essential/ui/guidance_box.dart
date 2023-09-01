import 'package:flutter/material.dart';

class GuidanceBox extends StatelessWidget {
  final List<Widget> children;
  final String? title;
  const GuidanceBox({
    super.key,
    required this.children,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16,top: 16,right: 16, bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null ? Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(16)
                ),
                child: Text(title!)),
          ) : SizedBox.shrink(),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: children,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
