import 'package:flutter/material.dart';

import '../../../dictionary/ui/dictionary.dart';
class ToDictionaryViewButton extends StatelessWidget {
  const ToDictionaryViewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(32),
        onTap: (){
          Navigator.push(
              context, MaterialPageRoute(builder:(context) => const DictionaryView(),)
          );
        },
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(16),
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Theme.of(context).cardColor,
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Diccon chat-based", style: TextStyle(
                  fontSize: 12
              ),
              ),
              Text("Dictionary", style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}