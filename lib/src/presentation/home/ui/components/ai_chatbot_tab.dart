import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../core/core.dart';
import '../../../ai_chatbot/ui/screens/voice_screen.dart';
import '../../../presentation.dart';

class AIChatbotTab extends StatelessWidget {
  const AIChatbotTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'In the premium version, you have the opportunity to chat with an AI specialized in language learning. Ready to answer any questions you have or become a conversational companion.'
                .i18n),
        Row(
          children: [
            Expanded(
                flex: 2,
                child: Opacity(
                  opacity: .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("I can even tell you a story !".i18n),
                    ],
                  ),
                )),
            Expanded(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(LocalDirectory.storiesIllustration),
                  height: 140,
                ),
              ),
            ),
          ],
        ),
        const WaveDivider(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          thickness: .3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FilledButton.tonalIcon(
                onPressed: () {
                  SeekFeedback.showFeedbackBottomSheet(context);
                  context.pushNamed(RouterConstants.conversation);
                },
                icon: const Icon(Icons.chat),
                label: Text('Text chat'.i18n)),
            if (kDebugMode)
              FilledButton.tonalIcon(
                  onPressed: () {
                    SeekFeedback.showFeedbackBottomSheet(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VoiceScreen()));
                  },
                  icon: const Icon(Icons.keyboard_voice),
                  label: Text('Voice only'.i18n)),
          ],
        )
      ],
    );
  }
}
