import 'package:diccon_evo/src/common/common.dart';
import 'package:diccon_evo/src/features/features.dart';
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
          child: Column(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(
                      LocalDirectory.getRandomIllustrationImage()),
                  height: 180,
                ),
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
                  "This practice will prepare you for various real-life conversation scenarios."
                      .i18n,
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
