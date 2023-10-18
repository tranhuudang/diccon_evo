import 'package:diccon_evo/config/properties.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/route_constants.dart';
import 'feature_button.dart';

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
            Properties.defaultSetting.numberOfEssentialLeft.toString(),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w500),
          ),
          Text(
            "words to learn".i18n,
          ),
          const Spacer(),
          Text(
            "1848 Essential English Words".i18n,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
