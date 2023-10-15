import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/route_constants.dart';
import '../../../../data/helpers/feedback_helper.dart';
import 'feature_button.dart';

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
                color: Theme.of(context).colorScheme.onPrimary,
              )),
          const SizedBox(height: 8),
          const Text(
            "Diccon dual-mode",
            style: TextStyle(fontSize: 12),
          ),
          const Text(
            "Dictionary",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
