import 'package:flutter/material.dart';

import '../../../word_history/ui/word_history.dart';
class ListHomeItem extends StatelessWidget {
  final String title;
  final Icon? icon;
  final String? trailing;
  const ListHomeItem({
    super.key, required this.title,  this.icon, this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32),
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(builder:(context) => HistoryView(),)
        );
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            height: 100,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(32),

            ),
            child:
            Row(
              children: [
                icon != null ? icon! : SizedBox.shrink(),
                SizedBox(width: 8,),
                Text(title,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                Spacer(),
                trailing != null ?
                Text(trailing!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),) : SizedBox.shrink(),
              ],
            )
            ,)
        ],
      ),
    );
  }
}

