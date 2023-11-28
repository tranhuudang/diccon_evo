import 'package:go_router/go_router.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';
class ToConversationButton extends StatelessWidget {
  const ToConversationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FeatureButton(
      onTap: () {
        SeekFeedback.showFeedbackBottomSheet(context);
        context.pushNamed(RouterConstants.conversation);

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Conversation".i18n,
            style:  context.theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Text(
            "Practice your communication skills".i18n,
            style: context.theme.textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}
