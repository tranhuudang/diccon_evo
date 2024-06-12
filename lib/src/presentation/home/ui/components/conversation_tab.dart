import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';

import '../../../../core/core.dart';
import '../../../presentation.dart';

class DialogueTab extends StatelessWidget {
  const DialogueTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            'This tab provides a list of dual-language English and Vietnamese dialogues on various topics. Feel free to explore and use them for your language practice.'
                .i18n),
        Row(
          children: [
            Expanded(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(LocalDirectory.historyIllustration),
                  height: 140,
                ),
              ),
            ),
            8.width,
            Expanded(
                flex: 3,
                child: Opacity(
                  opacity: .5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enhance your language skills with practical dialogues.".i18n),
                    ],
                  ),
                )),
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
                  context.pushNamed(RouterConstants.dialogue);
                },
                icon: const Icon(Icons.language),
                label: Text('Open Dialogue List'.i18n)),
          ],
        )
      ],
    );
  }
}
