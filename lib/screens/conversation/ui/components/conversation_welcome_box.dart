import 'package:diccon_evo/extensions/i18n.dart';
import 'package:diccon_evo/extensions/sized_box.dart';
import 'package:flutter/material.dart';

class ConversationWelcome extends StatelessWidget {
  const ConversationWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          padding: const EdgeInsets.only(top: 110, bottom: 20),
          child:  Column(
            children: [
              const Image(
                image: AssetImage('assets/stickers/book_glass.png'),
                width: 200,
              ),
              Text(
                "Enhance your communication skills with our advanced bot.".i18n,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox().mediumHeight(),
              Opacity(
                opacity: 0.5,
                child: Text(
                  "This practice will prepare you for various real-life conversation scenarios.".i18n,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
