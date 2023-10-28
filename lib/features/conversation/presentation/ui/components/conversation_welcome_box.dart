import 'package:flutter/material.dart';
import 'package:diccon_evo/common/common.dart';
import 'package:diccon_evo/features/features.dart';

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
                height: 180,
              ),
              Text(
                "Enhance your communication skills with our advanced bot.".i18n,
                style: context.theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing.medium(),
              Opacity(
                opacity: 0.5,
                child: Text(
                  "This practice will prepare you for various real-life conversation scenarios.".i18n,
                  style: context.theme.textTheme.bodyMedium,
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
