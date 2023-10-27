import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'feature_button.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
class ToReadingChamberButton extends StatelessWidget {
  const ToReadingChamberButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        context.pushNamed(RouterConstants.readingChamber);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Library".i18n,
            style:  Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            "For all levels and audiences".i18n,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
