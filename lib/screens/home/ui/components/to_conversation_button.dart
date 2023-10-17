import 'dart:ui';
import 'package:diccon_evo/data/helpers/feedback_helper.dart';
import 'package:diccon_evo/extensions/i18n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wave/config.dart';
import '../../../../config/route_constants.dart';
import 'feature_button.dart';
import 'package:wave/wave.dart';

class ToConversationButton extends StatelessWidget {
  const ToConversationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      borderColor: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.zero,
      onTap: () {
        FeedbackHelper.showFeedbackBottomSheet(context);
        context.pushNamed(RouterConstants.conversation);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: [
            Container(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.9),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat,
                        size: 30,
                        color: Theme.of(context).colorScheme.onPrimary),
                    const SizedBox(height: 4),
                    Text(
                      "Ask me anything".i18n,
                      style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text(
                      "Mr. Know It All",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: .5,
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    Colors.white70,
                    Colors.white54,
                    Colors.white30,
                    Colors.white24,
                  ],
                  durations: [32000, 21000, 18000, 5000],
                  heightPercentages: [0.75, 0.66, 0.68, 0.71],
                ),
                size: const Size(double.infinity, double.infinity),
                waveAmplitude: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
