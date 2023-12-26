import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class SearchStoryWelcome extends StatelessWidget {
  const SearchStoryWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 300,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
                context.theme.colorScheme.primary, BlendMode.srcIn),
            child: Image(
              image: AssetImage(
                  LocalDirectory.commonIllustration),
              height: 180,
            ),
          ),
          8.height,
          Text(
            "Never miss out on your story ever again".i18n,
            style: context.theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          8.height,
          Opacity(
            opacity: 0.5,
            child: Text(
              "You can search by using title, description, contents and author of the story."
                  .i18n,
              style: context.theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
