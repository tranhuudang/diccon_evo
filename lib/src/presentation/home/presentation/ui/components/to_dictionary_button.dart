import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class ToDictionaryButton extends StatelessWidget {
  const ToDictionaryButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        SeekFeedback.showFeedbackBottomSheet(context);
        context.pushNamed(RouterConstants.dictionary);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              decoration: BoxDecoration(
                color: context.theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(50),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.search,
                color: context.theme.colorScheme.surface,
              )),
          const VerticalSpacing.medium(),
          Text(
            "Diccon dual-mode",
            style: context.theme.textTheme.labelSmall,
          ),
          Text(
            "Dictionary".i18n,
            style: context.theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.w500),
          ),
          const VerticalSpacing.large(),
        ],
      ),
    );
  }
}
