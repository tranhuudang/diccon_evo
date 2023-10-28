import 'package:flutter/material.dart';
import 'package:diccon_evo/common/common.dart';
import 'package:diccon_evo/features/features.dart';

class DictionaryWelcome extends StatelessWidget {
  const DictionaryWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              const Image(
                image: AssetImage('assets/stickers/book.png'),
                height: 180,
              ),
              const VerticalSpacing.medium(),
              Text(
                "TitleWordInDictionaryWelcomeBox".i18n,
                style: context.theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const VerticalSpacing.medium(),
              Opacity(
                opacity: 0.5,
                child: Text(
                  "SubWordInDictionaryWelcomeBox".i18n,
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
