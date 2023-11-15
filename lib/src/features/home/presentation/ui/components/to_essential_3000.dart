import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
import 'package:flutter/material.dart';
class ToEssentialWordButton extends StatelessWidget {
  const ToEssentialWordButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        context.pushNamed(RouterConstants.essential1848);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Properties.instance.settings.numberOfEssentialLeft.toString(),
            style: context.theme.textTheme.headlineLarge?.copyWith(color: context.theme.colorScheme.primary, fontWeight: FontWeight.w500),
          ),
          Text(
            "words to learn".i18n,
          ),
          const Spacer(),
          Text(
            "1848 Essential English Words".i18n,
            style: context.theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
