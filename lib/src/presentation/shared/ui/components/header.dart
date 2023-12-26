import 'dart:ui';
import 'package:diccon_evo/src/presentation/presentation.dart';
import 'package:diccon_evo/src/core/core.dart';

class Header extends StatelessWidget {
  const Header({
    super.key,
    this.actions,
    this.title,
    this.childOfStack = true,
    this.enableBackButton = true,
  });

  final List<Widget>? actions;
  final String? title;
  final bool? childOfStack;
  final bool? enableBackButton;

  @override
  Widget build(BuildContext context) {
    return childOfStack!
        ? Column(
            children: [
              HeaderWithBlurEffect(title: title, actions: actions, enableBackButton: enableBackButton!,),
              const Spacer(),
            ],
          )
        : HeaderWithBlurEffect(title: title, actions: actions, enableBackButton: enableBackButton!,);
  }
}

class HeaderWithBlurEffect extends StatelessWidget {
  const HeaderWithBlurEffect({
    super.key,
    required this.title,
    required this.actions,
    required this.enableBackButton,
  });

  final String? title;
  final List<Widget>? actions;
  final bool enableBackButton;

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Stack(
        children: [
          // Blur layers
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 4.0,
              sigmaY: 4.0,
            ),
            child: const SizedBox.shrink(),
          ),
          // Child layers
          Container(
            height: 66,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  context.theme.colorScheme.background.withOpacity(0.9),
                  context.theme.colorScheme.background.withOpacity(0.5),
                ])),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (enableBackButton) ...[
                  CircleButton(
                      backgroundColor: context.theme.colorScheme.surfaceVariant
                          .withOpacity(.5),
                      icon: const Icon(Icons.arrow_back),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                  16.height,
                ],
                if (title != null)
                  Text(
                    title!,
                    style: context.theme.textTheme.headlineSmall,
                  ),
                const SizedBox(
                  width: 16,
                ),
                const Spacer(),
                if (actions != null)
                  Row(
                    children: actions!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
