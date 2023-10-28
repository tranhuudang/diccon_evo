import 'package:flutter/material.dart';
import 'package:diccon_evo/src/common/common.dart';

class ConversationMachineBubble extends StatelessWidget {
  final String content;
  const ConversationMachineBubble({
    Key? key, required this.content,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 8, 16, 8),
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
        decoration: BoxDecoration(
          color: context.theme.colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(0.0),
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child:
              content != "" ? Align(
                alignment: Alignment.topLeft,
                child: SelectableText(
                  content,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.onSecondary),
                ),
              ):
          Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: context.theme.colorScheme.onSecondary,),))
          ,
          ),
        ),
    );
  }
}
