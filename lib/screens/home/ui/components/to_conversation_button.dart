import 'dart:ui';

import 'package:diccon_evo/data/helpers/feedback_helper.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/route_constants.dart';
import 'feature_button.dart';

class ToConversationButton extends StatelessWidget {
  const ToConversationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      borderColor: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      image: const DecorationImage(
        image: AssetImage("assets/theme/theme-1-1.png"),
      ),
      onTap: () {
        FeedbackHelper.showFeedbackBottomSheet(context);
        context.pushNamed(RouterConstants.conversation);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 2.0,
              sigmaY: 5),
          child: Container(
            color: Theme.of(context).primaryColor.withOpacity(0.8),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.chat,
                    size: 40,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Ask me anything".i18n,
                    style: const TextStyle(fontSize: 12),
                  ),
                  const Text(
                    "Mr. Know It All",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
