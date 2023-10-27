import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:diccon_evo/features/features.dart';
import 'package:diccon_evo/common/common.dart';
class ToDictionaryButton extends StatelessWidget {
  const ToDictionaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        FeedbackHelper.showFeedbackBottomSheet(context);
        context.pushNamed(RouterConstants.dictionary);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.surface,
              )),
          const SizedBox(height: 8),
           Text(
            "Diccon dual-mode",
            style: Theme.of(context).textTheme.labelSmall,
          ),
           Text(
            "Dictionary".i18n,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
