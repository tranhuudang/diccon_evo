import 'package:diccon_evo/src/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:wave_divider/wave_divider.dart';
import '../../../presentation.dart';

class DictionaryTab extends StatelessWidget {
  const DictionaryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              child: Text(
                'Access an extensive dictionary repository offering advanced customizations tailored to best suit your needs.'.i18n,
                style: context.theme.textTheme.bodyMedium,
              ),
            ),
            8.width,
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                  context.theme.colorScheme.primary,
                  BlendMode.srcIn),
              child: Image(
                image: AssetImage(LocalDirectory.dictionaryIllustration),
                height: 140,
              ),
            ),

          ],
        ),
        8.height,
        const WaveDivider(
          padding: EdgeInsets.symmetric(
            vertical: 16,
          ),
          thickness: .3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
                onPressed: () {
                  context.pushNamed(RouterConstants.dictionary);
                },
                child: Text('Open dictionary'.i18n)),
            4.width,
            IconButton.filledTonal(
                onPressed: () {
                  context.pushNamed(RouterConstants.wordHistory);
                },
                icon: const Icon(Icons.history)),
            IconButton.filledTonal(
                onPressed: () {
                  context.pushNamed(RouterConstants.dictionaryPreferences);
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
      ],
    );
  }
}
