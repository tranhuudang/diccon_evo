import 'package:go_router/go_router.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class PageErrorView extends StatelessWidget {
  const PageErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.surface,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(
                        context.theme.colorScheme.primary, BlendMode.srcIn),
                    child: Image(
                      image: AssetImage(
                          LocalDirectory.getRandomIllustrationImage()),
                      height: 180,
                    ),
                  ),
                  const VerticalSpacing.large(),
                  Text(
                    "Oops, something went wrong".i18n,
                    style: context.theme.textTheme.titleMedium,
                  ),
                  const VerticalSpacing.medium(),
                  Text("The page is broken, please try to reload again.".i18n),
                ],
              ),
            ),

            /// Header
            Header(
              title: "Uninvited guest".i18n,
            ),
          ],
        ),
      ),
    );
  }
}
