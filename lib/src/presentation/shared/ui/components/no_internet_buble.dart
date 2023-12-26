import 'package:diccon_evo/src/core/core.dart';
import 'package:diccon_evo/src/presentation/presentation.dart';

class NoInternetBubble extends StatelessWidget {
  const NoInternetBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 32),
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(0.0),
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
            child:  Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        height: 200,
                        image: AssetImage(LocalDirectory.commonIllustration),
                      ),
                    ],
                  ),
                  Text("You're not connected".i18n, style: context.theme.textTheme.titleLarge,),
                  8.height,
                  Text("SubSentenceInNoInternetBubble".i18n),
                ],
              ),
            ),
          ),
        ));
  }
}
