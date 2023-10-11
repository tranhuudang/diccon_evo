import 'package:flutter/material.dart';

class ChatbotBubblePreview extends StatelessWidget {
  final String textReturn;

  const ChatbotBubblePreview({super.key, required this.textReturn});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.volume_up, size: 20,),
                    )],
                  ),
                  Text(textReturn)
                  // SelectableText(
                  //     answer),
                ],
              ),
            ),
          ),
        ));
  }
}
