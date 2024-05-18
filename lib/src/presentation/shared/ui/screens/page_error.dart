import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class PageErrorView extends StatelessWidget {
  const PageErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                          LocalDirectory.commonIllustration),
                      height: 180,
                    ),
                  ),
                  16.height,
                  Text(
                    "Oops, something went wrong".i18n,
                    style: context.theme.textTheme.titleMedium,
                  ),
                  8.height,
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
