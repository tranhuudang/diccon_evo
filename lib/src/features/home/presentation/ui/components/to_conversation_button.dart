import 'package:go_router/go_router.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:diccon_evo/src/features/features.dart';
import 'package:diccon_evo/src/common/common.dart';
class ToConversationButton extends StatelessWidget {
  const ToConversationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final onPrimary = context.theme.colorScheme.onPrimary;
    return FeatureButton(
      borderColor: context.theme.scaffoldBackgroundColor,
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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 22),
              color: context.theme.colorScheme.primary.withOpacity(0.9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 14,),
                  Icon(Icons.chat,
                      size: 32,
                      color: context.theme.colorScheme.onPrimary),
                  const SizedBox(height: 4),
                  Text(
                    "Ask me anything".i18n,
                    style: context.theme.textTheme.labelSmall?.copyWith(color:onPrimary ),
                  ),
                  Text(
                    "Javis",
                    style:  context.theme.textTheme.titleLarge?.copyWith(color:onPrimary, fontWeight: FontWeight.w500 ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            Opacity(
              opacity: .5,
              child: WaveWidget(
                duration: 3000,
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
