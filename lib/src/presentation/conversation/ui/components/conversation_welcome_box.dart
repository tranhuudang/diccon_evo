import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class ConversationWelcome extends StatelessWidget {
  const ConversationWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 300,
          padding: const EdgeInsets.only(top: 110, bottom: 20),
          child: Column(
            children: [
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                    context.theme.colorScheme.primary, BlendMode.srcIn),
                child: Image(
                  image: AssetImage(
                      LocalDirectory.conversationIllustration),
                  height: 180,
                ),
              ),
              16.height,
              Text(
                "Enhance your communication skills with our advanced bot.".i18n,
                style: context.theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              16.height,
              Opacity(
                opacity: 0.5,
                child: Text(
                  "This practice will prepare you for various real-life conversation scenarios."
                      .i18n,
                  style: context.theme.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
