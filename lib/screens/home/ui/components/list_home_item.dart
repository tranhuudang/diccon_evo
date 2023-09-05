import 'package:flutter/material.dart';

import '../../../word_history/ui/word_history.dart';
class ListHomeItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final Icon? icon;
  final String? trailing;
  final double? height;
  const ListHomeItem({
    super.key, required this.title,  this.icon, this.trailing, required this.onTap, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        height: height?? 200,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(32),

        ),
        child:
        Row(
          children: [
            icon != null ? icon! : const SizedBox.shrink(),
            const SizedBox(width: 16,),
            Text(title,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            const Spacer(),
            trailing != null ?
            Text(trailing!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),) : const SizedBox.shrink(),
          ],
        )
        ,),
    );
  }
}

